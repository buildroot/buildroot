#!/usr/bin/env python3

# Copyright (C) 2009 by Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
# Copyright (C) 2020 by Gregory CLEMENT <gregory.clement@bootlin.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

import datetime
import os
import distutils.version
import json
import subprocess
import sys
import operator

sys.path.append('utils/')

NVD_START_YEAR = 1999
NVD_BASE_URL = "https://github.com/fkie-cad/nvd-json-data-feeds/"

ops = {
    '>=': operator.ge,
    '>': operator.gt,
    '<=': operator.le,
    '<': operator.lt,
    '=': operator.eq
}


# Check if two CPE IDs match each other
def cpe_matches(cpe1, cpe2):
    cpe1_elems = cpe1.split(":")
    cpe2_elems = cpe2.split(":")

    remains = filter(lambda x: x[0] not in ["*", "-"] and x[1] not in ["*", "-"] and x[0] != x[1],
                     zip(cpe1_elems, cpe2_elems))
    return len(list(remains)) == 0


def cpe_product(cpe):
    return cpe.split(':')[4]


def cpe_version(cpe):
    return cpe.split(':')[5]


class CVE:
    """An accessor class for CVE Items in NVD files"""
    CVE_AFFECTS = 1
    CVE_DOESNT_AFFECT = 2
    CVE_UNKNOWN = 3

    def __init__(self, nvd_cve):
        """Initialize a CVE from its NVD JSON representation"""
        self.nvd_cve = nvd_cve

    @staticmethod
    def download_nvd(nvd_git_dir):
        print(f"Updating from {NVD_BASE_URL}")
        if os.path.exists(nvd_git_dir):
            subprocess.check_call(
                ["git", "pull"],
                cwd=nvd_git_dir,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
        else:
            # Create the directory and its parents; git
            # happily clones into an empty directory.
            os.makedirs(nvd_git_dir)
            subprocess.check_call(
                ["git", "clone", NVD_BASE_URL, nvd_git_dir],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )

    @staticmethod
    def sort_id(cve_ids):
        def cve_key(cve_id):
            year, id_ = cve_id.split('-')[1:]
            return (int(year), int(id_))
        return sorted(cve_ids, key=cve_key)

    @classmethod
    def read_nvd_dir(cls, nvd_dir):
        """
        Iterate over all the CVEs contained in NIST Vulnerability Database
        feeds since NVD_START_YEAR. If the files are missing or outdated in
        nvd_dir, a fresh copy will be downloaded, and kept in .json.gz
        """
        nvd_git_dir = os.path.join(nvd_dir, "git")
        CVE.download_nvd(nvd_git_dir)
        for year in range(NVD_START_YEAR, datetime.datetime.now().year + 1):
            for dirpath, _, filenames in os.walk(os.path.join(nvd_git_dir, f"CVE-{year}")):
                for filename in filenames:
                    if filename[-5:] != ".json":
                        continue
                    with open(os.path.join(dirpath, filename), "rb") as f:
                        yield cls(json.load(f))

    def parse_node(self, node):
        """
        Parse the node inside the configurations section to extract the
        cpe information useful to know if a product is affected by
        the CVE. Actually only the product name and the version
        descriptor are needed, but we also provide the vendor name.
        """

        # The node containing the cpe entries matching the CVE can also
        # contain sub-nodes, so we need to manage it.
        for child in node.get('children', ()):
            for parsed_node in self.parse_node(child):
                yield parsed_node

        for cpe in node.get('cpeMatch', ()):
            if not cpe['vulnerable']:
                return
            product = cpe_product(cpe['criteria'])
            version = cpe_version(cpe['criteria'])
            # ignore when product is '-', which means N/A
            if product == '-':
                return
            op_start = ''
            op_end = ''
            v_start = ''
            v_end = ''

            if version != '*' and version != '-':
                # Version is defined, this is a '=' match
                op_start = '='
                v_start = version
            else:
                # Parse start version, end version and operators
                if 'versionStartIncluding' in cpe:
                    op_start = '>='
                    v_start = cpe['versionStartIncluding']

                if 'versionStartExcluding' in cpe:
                    op_start = '>'
                    v_start = cpe['versionStartExcluding']

                if 'versionEndIncluding' in cpe:
                    op_end = '<='
                    v_end = cpe['versionEndIncluding']

                if 'versionEndExcluding' in cpe:
                    op_end = '<'
                    v_end = cpe['versionEndExcluding']

            yield {
                'id': cpe['criteria'],
                'v_start': v_start,
                'op_start': op_start,
                'v_end': v_end,
                'op_end': op_end
            }

    def each_cpe(self):
        for nodes in self.nvd_cve.get('configurations', []):
            for node in nodes['nodes']:
                for cpe in self.parse_node(node):
                    yield cpe

    @property
    def identifier(self):
        """The CVE unique identifier"""
        return self.nvd_cve['id']

    @property
    def affected_products(self):
        """The set of CPE products referred by this CVE definition"""
        return set(cpe_product(p['id']) for p in self.each_cpe())

    def affects(self, name, version, cpeid=None):
        """
        True if the Buildroot Package object passed as argument is affected
        by this CVE.
        """

        pkg_version = distutils.version.LooseVersion(version)
        if not hasattr(pkg_version, "version"):
            print("Cannot parse package '%s' version '%s'" % (name, version))
            pkg_version = None

        # if we don't have a cpeid, build one based on name and version
        if not cpeid:
            cpeid = "cpe:2.3:*:*:%s:%s:*:*:*:*:*:*:*" % (name, version)
        # if we have a cpeid, use its version instead of the package
        # version, as they might be different due to
        # <pkg>_CPE_ID_VERSION
        else:
            pkg_version = distutils.version.LooseVersion(cpe_version(cpeid))

        for cpe in self.each_cpe():
            if not cpe_matches(cpe['id'], cpeid):
                continue
            if not cpe['v_start'] and not cpe['v_end']:
                return self.CVE_AFFECTS
            if not pkg_version:
                continue

            if cpe['v_start']:
                try:
                    cve_affected_version = distutils.version.LooseVersion(cpe['v_start'])
                    inrange = ops.get(cpe['op_start'])(pkg_version, cve_affected_version)
                except TypeError:
                    return self.CVE_UNKNOWN

                # current package version is before v_start, so we're
                # not affected by the CVE
                if not inrange:
                    continue

            if cpe['v_end']:
                try:
                    cve_affected_version = distutils.version.LooseVersion(cpe['v_end'])
                    inrange = ops.get(cpe['op_end'])(pkg_version, cve_affected_version)
                except TypeError:
                    return self.CVE_UNKNOWN

                # current package version is after v_end, so we're
                # not affected by the CVE
                if not inrange:
                    continue

            # We're in the version range affected by this CVE
            return self.CVE_AFFECTS

        return self.CVE_DOESNT_AFFECT
