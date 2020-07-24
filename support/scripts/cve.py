#!/usr/bin/env python

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
import requests  # URL checking
import distutils.version
import time
import gzip
import sys

try:
    import ijson
except ImportError:
    sys.stderr.write("You need ijson to parse NVD for CVE check\n")
    exit(1)

sys.path.append('utils/')

NVD_START_YEAR = 2002
NVD_JSON_VERSION = "1.0"
NVD_BASE_URL = "https://nvd.nist.gov/feeds/json/cve/" + NVD_JSON_VERSION

class CVE:
    """An accessor class for CVE Items in NVD files"""
    CVE_AFFECTS = 1
    CVE_DOESNT_AFFECT = 2
    CVE_UNKNOWN = 3

    def __init__(self, nvd_cve):
        """Initialize a CVE from its NVD JSON representation"""
        self.nvd_cve = nvd_cve

    @staticmethod
    def download_nvd_year(nvd_path, year):
        metaf = "nvdcve-%s-%s.meta" % (NVD_JSON_VERSION, year)
        path_metaf = os.path.join(nvd_path, metaf)
        jsonf_gz = "nvdcve-%s-%s.json.gz" % (NVD_JSON_VERSION, year)
        path_jsonf_gz = os.path.join(nvd_path, jsonf_gz)

        # If the database file is less than a day old, we assume the NVD data
        # locally available is recent enough.
        if os.path.exists(path_jsonf_gz) and os.stat(path_jsonf_gz).st_mtime >= time.time() - 86400:
            return path_jsonf_gz

        # If not, we download the meta file
        url = "%s/%s" % (NVD_BASE_URL, metaf)
        print("Getting %s" % url)
        page_meta = requests.get(url)
        page_meta.raise_for_status()

        # If the meta file already existed, we compare the existing
        # one with the data newly downloaded. If they are different,
        # we need to re-download the database.
        # If the database does not exist locally, we need to redownload it in
        # any case.
        if os.path.exists(path_metaf) and os.path.exists(path_jsonf_gz):
            meta_known = open(path_metaf, "r").read()
            if page_meta.text == meta_known:
                return path_jsonf_gz

        # Grab the compressed JSON NVD, and write files to disk
        url = "%s/%s" % (NVD_BASE_URL, jsonf_gz)
        print("Getting %s" % url)
        page_json = requests.get(url)
        page_json.raise_for_status()
        open(path_jsonf_gz, "wb").write(page_json.content)
        open(path_metaf, "w").write(page_meta.text)
        return path_jsonf_gz

    @classmethod
    def read_nvd_dir(cls, nvd_dir):
        """
        Iterate over all the CVEs contained in NIST Vulnerability Database
        feeds since NVD_START_YEAR. If the files are missing or outdated in
        nvd_dir, a fresh copy will be downloaded, and kept in .json.gz
        """
        for year in range(NVD_START_YEAR, datetime.datetime.now().year + 1):
            filename = CVE.download_nvd_year(nvd_dir, year)
            try:
                content = ijson.items(gzip.GzipFile(filename), 'CVE_Items.item')
            except:  # noqa: E722
                print("ERROR: cannot read %s. Please remove the file then rerun this script" % filename)
                raise
            for cve in content:
                yield cls(cve['cve'])

    def each_product(self):
        """Iterate over each product section of this cve"""
        for vendor in self.nvd_cve['affects']['vendor']['vendor_data']:
            for product in vendor['product']['product_data']:
                yield product

    @property
    def identifier(self):
        """The CVE unique identifier"""
        return self.nvd_cve['CVE_data_meta']['ID']

    @property
    def pkg_names(self):
        """The set of package names referred by this CVE definition"""
        return set(p['product_name'] for p in self.each_product())

    def affects(self, br_pkg):
        """
        True if the Buildroot Package object passed as argument is affected
        by this CVE.
        """
        if br_pkg.is_cve_ignored(self.identifier):
            return self.CVE_DOESNT_AFFECT

        for product in self.each_product():
            if product['product_name'] != br_pkg.name:
                continue

            for v in product['version']['version_data']:
                if v["version_affected"] == "=":
                    if v["version_value"] == "-":
                        return self.CVE_AFFECTS
                    elif br_pkg.current_version == v["version_value"]:
                        return self.CVE_AFFECTS
                elif v["version_affected"] == "<=":
                    pkg_version = distutils.version.LooseVersion(br_pkg.current_version)
                    if not hasattr(pkg_version, "version"):
                        print("Cannot parse package '%s' version '%s'" % (br_pkg.name, br_pkg.current_version))
                        continue
                    cve_affected_version = distutils.version.LooseVersion(v["version_value"])
                    if not hasattr(cve_affected_version, "version"):
                        print("Cannot parse CVE affected version '%s'" % v["version_value"])
                        continue
                    try:
                        affected = pkg_version <= cve_affected_version
                    except TypeError:
                        return self.CVE_UNKNOWN
                    if affected:
                        return self.CVE_AFFECTS
                    else:
                        return self.CVE_DOESNT_AFFECT
                else:
                    print("version_affected: %s" % v['version_affected'])
        return self.CVE_DOESNT_AFFECT
