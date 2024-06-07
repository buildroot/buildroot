# See utils/checkpackagelib/readme.txt before editing this file.
# There are already dependency checks during the build, so below check
# functions don't need to check for things already checked by exploring the
# menu options using "make menuconfig" and by running "make" with appropriate
# packages enabled.

import os
import re

from checkpackagelib.base import _CheckFunction
from checkpackagelib.lib import ConsecutiveEmptyLines  # noqa: F401
from checkpackagelib.lib import EmptyLastLine          # noqa: F401
from checkpackagelib.lib import NewlineAtEof           # noqa: F401
from checkpackagelib.lib import TrailingSpace          # noqa: F401
from checkpackagelib.lib import Utf8Characters         # noqa: F401
from checkpackagelib.tool import NotExecutable         # noqa: F401

# used in more than one check
start_conditional = ["ifdef", "ifeq", "ifndef", "ifneq"]
continue_conditional = ["elif", "else"]
end_conditional = ["endif"]


class DoNotInstallToHostdirUsr(_CheckFunction):
    INSTALL_TO_HOSTDIR_USR = re.compile(r"^[^#].*\$\(HOST_DIR\)/usr")

    def check_line(self, lineno, text):
        if self.INSTALL_TO_HOSTDIR_USR.match(text.rstrip()):
            return ["{}:{}: install files to $(HOST_DIR)/ instead of $(HOST_DIR)/usr/"
                    .format(self.filename, lineno),
                    text]


class Ifdef(_CheckFunction):
    IFDEF = re.compile(r"^\s*(else\s+|)(ifdef|ifndef)\s")

    def check_line(self, lineno, text):
        m = self.IFDEF.search(text)
        if m is None:
            return
        word = m.group(2)
        if word == 'ifdef':
            return ["{}:{}: use ifeq ($(SYMBOL),y) instead of ifdef SYMBOL"
                    .format(self.filename, lineno),
                    text]
        else:
            return ["{}:{}: use ifneq ($(SYMBOL),y) instead of ifndef SYMBOL"
                    .format(self.filename, lineno),
                    text]


def get_package_prefix_from_filename(filename):
    """Return a tuple (pkgname, PKGNAME) with the package name derived from the file name"""
    # Double splitext to support .mk.in
    package = os.path.splitext(os.path.splitext(os.path.basename(filename))[0])[0]
    # linux tools do not use LINUX_TOOL_ prefix for variables
    package = package.replace("linux-tool-", "")
    # linux extensions do not use LINUX_EXT_ prefix for variables
    package = package.replace("linux-ext-", "")
    package_upper = package.replace("-", "_").upper()
    return package, package_upper


class Indent(_CheckFunction):
    COMMENT = re.compile(r"^\s*#")
    CONDITIONAL = re.compile(r"^\s*({})\s".format("|".join(start_conditional + end_conditional + continue_conditional)))
    ENDS_WITH_BACKSLASH = re.compile(r"^[^#].*\\$")
    END_DEFINE = re.compile(r"^\s*endef\s")
    MAKEFILE_TARGET = re.compile(r"^[^# \t]+:\s")
    START_DEFINE = re.compile(r"^\s*define\s")

    def before(self):
        self.define = False
        self.backslash = False
        self.makefile_target = False

    def check_line(self, lineno, text):
        if self.START_DEFINE.search(text):
            self.define = True
            return
        if self.END_DEFINE.search(text):
            self.define = False
            return

        expect_tabs = False
        if self.define or self.backslash or self.makefile_target:
            expect_tabs = True
        if not self.backslash and self.CONDITIONAL.search(text):
            expect_tabs = False

        # calculate for next line
        if self.ENDS_WITH_BACKSLASH.search(text):
            self.backslash = True
        else:
            self.backslash = False

        if self.MAKEFILE_TARGET.search(text):
            self.makefile_target = True
            return
        if text.strip() == "":
            self.makefile_target = False
            return

        # comment can be indented or not inside define ... endef, so ignore it
        if self.define and self.COMMENT.search(text):
            return

        if expect_tabs:
            if not text.startswith("\t"):
                return ["{}:{}: expected indent with tabs"
                        .format(self.filename, lineno),
                        text]
        else:
            if text.startswith("\t"):
                return ["{}:{}: unexpected indent with tabs"
                        .format(self.filename, lineno),
                        text]


class OverriddenVariable(_CheckFunction):
    CONCATENATING = re.compile(r"^([A-Z0-9_]+)\s*(\+|:|)=\s*\$\(\1\)")
    END_CONDITIONAL = re.compile(r"^\s*({})".format("|".join(end_conditional)))
    OVERRIDING_ASSIGNMENTS = [':=', "="]
    START_CONDITIONAL = re.compile(r"^\s*({})".format("|".join(start_conditional)))
    VARIABLE = re.compile(r"^([A-Z0-9_]+)\s*((\+|:|)=)")
    USUALLY_OVERRIDDEN = re.compile(r"^[A-Z0-9_]+({})".format("|".join([
        r"_ARCH\s*=\s*",
        r"_CPU\s*=\s*",
        r"_SITE\s*=\s*",
        r"_SOURCE\s*=\s*",
        r"_VERSION\s*=\s*"])))
    FORBIDDEN_OVERRIDDEN = re.compile(r"^[A-Z0-9_]+({})".format("|".join([
        r"_CONF_OPTS\s*=\s*",
        r"_DEPENDENCIES\s*=\s*"])))

    def before(self):
        self.conditional = 0
        self.unconditionally_set = []
        self.conditionally_set = []

    def check_line(self, lineno, text):
        if self.START_CONDITIONAL.search(text):
            self.conditional += 1
            return
        if self.END_CONDITIONAL.search(text):
            self.conditional -= 1
            return

        m = self.VARIABLE.search(text)
        if m is None:
            return
        variable, assignment = m.group(1, 2)

        if self.conditional == 0:
            if variable in self.conditionally_set:
                self.unconditionally_set.append(variable)
                if assignment in self.OVERRIDING_ASSIGNMENTS:
                    return ["{}:{}: unconditional override of variable {} previously conditionally set"
                            .format(self.filename, lineno, variable),
                            text]

            if variable not in self.unconditionally_set:
                self.unconditionally_set.append(variable)
                return
            if assignment in self.OVERRIDING_ASSIGNMENTS:
                return ["{}:{}: unconditional override of variable {}"
                        .format(self.filename, lineno, variable),
                        text]
        else:
            if self.FORBIDDEN_OVERRIDDEN.search(text):
                return ["{}:{}: conditional override of variable {}"
                        .format(self.filename, lineno, variable),
                        text]
            if variable not in self.unconditionally_set:
                self.conditionally_set.append(variable)
                return
            if self.CONCATENATING.search(text):
                return ["{}:{}: immediate assignment to append to variable {}"
                        .format(self.filename, lineno, variable),
                        text]
            if self.USUALLY_OVERRIDDEN.search(text):
                return
            if assignment in self.OVERRIDING_ASSIGNMENTS:
                return ["{}:{}: conditional override of variable {}"
                        .format(self.filename, lineno, variable),
                        text]


class PackageHeader(_CheckFunction):
    def before(self):
        self.skip = False

    def check_line(self, lineno, text):
        if self.skip or lineno > 6:
            return

        if lineno in [1, 5]:
            if lineno == 1 and text.startswith("include "):
                self.skip = True
                return
            if text.rstrip() != "#" * 80:
                return ["{}:{}: should be 80 hashes ({}#writing-rules-mk)"
                        .format(self.filename, lineno, self.url_to_manual),
                        text,
                        "#" * 80]
        elif lineno in [2, 4]:
            if text.rstrip() != "#":
                return ["{}:{}: should be 1 hash ({}#writing-rules-mk)"
                        .format(self.filename, lineno, self.url_to_manual),
                        text]
        elif lineno == 6:
            if text.rstrip() != "":
                return ["{}:{}: should be a blank line ({}#writing-rules-mk)"
                        .format(self.filename, lineno, self.url_to_manual),
                        text]


class RemoveDefaultPackageSourceVariable(_CheckFunction):
    packages_that_may_contain_default_source = ["binutils", "gcc", "gdb"]

    def before(self):
        self.package, package_upper = get_package_prefix_from_filename(self.filename)
        self.FIND_SOURCE = re.compile(
            r"^{}_SOURCE\s*=\s*{}-\$\({}_VERSION\)\.tar\.gz"
            .format(package_upper, self.package, package_upper))

    def check_line(self, lineno, text):
        if self.FIND_SOURCE.search(text):

            if self.package in self.packages_that_may_contain_default_source:
                return

            return ["{}:{}: remove default value of _SOURCE variable "
                    "({}#generic-package-reference)"
                    .format(self.filename, lineno, self.url_to_manual),
                    text]


class SpaceBeforeBackslash(_CheckFunction):
    TAB_OR_MULTIPLE_SPACES_BEFORE_BACKSLASH = re.compile(r"^.*(  |\t ?)\\$")

    def check_line(self, lineno, text):
        if self.TAB_OR_MULTIPLE_SPACES_BEFORE_BACKSLASH.match(text.rstrip()):
            return ["{}:{}: use only one space before backslash"
                    .format(self.filename, lineno),
                    text]


class TrailingBackslash(_CheckFunction):
    ENDS_WITH_BACKSLASH = re.compile(r"^[^#].*\\$")

    def before(self):
        self.backslash = False

    def check_line(self, lineno, text):
        last_line_ends_in_backslash = self.backslash

        # calculate for next line
        if self.ENDS_WITH_BACKSLASH.search(text):
            self.backslash = True
            self.lastline = text
            return
        self.backslash = False

        if last_line_ends_in_backslash and text.strip() == "":
            return ["{}:{}: remove trailing backslash"
                    .format(self.filename, lineno - 1),
                    self.lastline]


class TypoInPackageVariable(_CheckFunction):
    ALLOWED = re.compile(r"|".join([
        "ACLOCAL_DIR",
        "ACLOCAL_HOST_DIR",
        "ACLOCAL_PATH",
        "BR_CCACHE_INITIAL_SETUP",
        "BR_LIBC",
        "BR_NO_CHECK_HASH_FOR",
        "GCC_TARGET",
        "LINUX_EXTENSIONS",
        "LINUX_POST_PATCH_HOOKS",
        "LINUX_TOOLS",
        "LUA_RUN",
        "MKFS_JFFS2",
        "MKIMAGE_ARCH",
        "PACKAGES_PERMISSIONS_TABLE",
        "PKG_CONFIG_HOST_BINARY",
        "SUMTOOL",
        "TARGET_FINALIZE_HOOKS",
        "TARGETS_ROOTFS",
        "XTENSA_CORE_NAME"]))
    VARIABLE = re.compile(r"^(define\s+)?([A-Z0-9_]+_[A-Z0-9_]+)")

    def before(self):
        _, self.package = get_package_prefix_from_filename(self.filename)
        self.REGEX = re.compile(r"(HOST_|ROOTFS_)?({}_[A-Z0-9_]+)".format(self.package))
        self.FIND_VIRTUAL = re.compile(
            r"^{}_PROVIDES\s*(\+|)=\s*(.*)".format(self.package))
        self.virtual = []

    def check_line(self, lineno, text):
        m = self.VARIABLE.search(text)
        if m is None:
            return

        variable = m.group(2)

        # allow to set variables for virtual package this package provides
        v = self.FIND_VIRTUAL.search(text)
        if v:
            self.virtual += v.group(2).upper().split()
            return
        for virtual in self.virtual:
            if variable.startswith("{}_".format(virtual)):
                return

        if self.ALLOWED.match(variable):
            return
        if self.REGEX.search(variable) is None:
            return ["{}:{}: possible typo, variable not properly prefixed: {} -> *{}_XXXX* ({}#_tips_and_tricks)"
                    .format(self.filename, lineno, variable, self.package, self.url_to_manual),
                    text]


class UselessFlag(_CheckFunction):
    DEFAULT_AUTOTOOLS_FLAG = re.compile(r"^.*{}".format("|".join([
        r"_AUTORECONF\s*=\s*NO",
        r"_LIBTOOL_PATCH\s*=\s*YES"])))
    DEFAULT_GENERIC_FLAG = re.compile(r"^.*{}".format("|".join([
        r"_INSTALL_IMAGES\s*=\s*NO",
        r"_REDISTRIBUTE\s*=\s*YES",
        r"_INSTALL_STAGING\s*=\s*NO",
        r"_INSTALL_TARGET\s*=\s*YES"])))
    END_CONDITIONAL = re.compile(r"^\s*({})".format("|".join(end_conditional)))
    START_CONDITIONAL = re.compile(r"^\s*({})".format("|".join(start_conditional)))

    def before(self):
        self.conditional = 0

    def check_line(self, lineno, text):
        if self.START_CONDITIONAL.search(text):
            self.conditional += 1
            return
        if self.END_CONDITIONAL.search(text):
            self.conditional -= 1
            return

        # allow non-default conditionally overridden by default
        if self.conditional > 0:
            return

        if self.DEFAULT_GENERIC_FLAG.search(text):
            return ["{}:{}: useless default value ({}#"
                    "_infrastructure_for_packages_with_specific_build_systems)"
                    .format(self.filename, lineno, self.url_to_manual),
                    text]

        if self.DEFAULT_AUTOTOOLS_FLAG.search(text) and not text.lstrip().startswith("HOST_"):
            return ["{}:{}: useless default value "
                    "({}#_infrastructure_for_autotools_based_packages)"
                    .format(self.filename, lineno, self.url_to_manual),
                    text]


class VariableWithBraces(_CheckFunction):
    VARIABLE_WITH_BRACES = re.compile(r"^[^#].*[^$]\${\w+}")

    def check_line(self, lineno, text):
        if self.VARIABLE_WITH_BRACES.match(text.rstrip()):
            return ["{}:{}: use $() to delimit variables, not ${{}}"
                    .format(self.filename, lineno),
                    text]


class CPEVariables(_CheckFunction):
    """
    Check that the values for the CPE variables are not the default.
      - CPE_ID_* variables must not be set to their default
      - CPE_ID_VALID must not be set if a non-default CPE_ID variable is set
    """
    def before(self):
        pkg, _ = os.path.splitext(os.path.basename(self.filename))
        self.CPE_fields_defaults = {
            "VALID": "NO",
            "PREFIX": "cpe:2.3:a",
            "VENDOR": f"{pkg}_project",
            "PRODUCT": pkg,
            "VERSION": None,
            "UPDATE": "*",
        }
        self.valid = None
        self.non_defaults = 0
        self.CPE_FIELDS_RE = re.compile(
            r"^\s*(.+_CPE_ID_({}))\s*=\s*(.+)$"
            .format("|".join(self.CPE_fields_defaults)),
        )
        self.VERSION_RE = re.compile(
            rf"^(HOST_)?{pkg.upper().replace('-', '_')}_VERSION\s*=\s*(.+)$",
        )
        self.COMMENT_RE = re.compile(r"^\s*#.*")

    def check_line(self, lineno, text):
        text = self.COMMENT_RE.sub('', text.rstrip())

        # WARNING! The VERSION_RE can _also_ match the same lines as CPE_FIELDS_RE,
        # but not the other way around. So we must first check for CPE_FIELDS_RE,
        # and if not matched, then and only then check for VERSION_RE.
        match = self.CPE_FIELDS_RE.match(text)
        if match:
            var, field, val = match.groups()
            return self._check_field(lineno, text, field, var, val)

        match = self.VERSION_RE.match(text)
        if match:
            self.CPE_fields_defaults["VERSION"] = match.groups()[1]

    def after(self):
        # "VALID" counts in the non-defaults; so when "VALID" is present,
        # 1 non-default means only "VALID" is present, so that's OK.
        if self.valid and self.non_defaults > 1:
            return ["{}:{}: 'YES' is implied when a non-default CPE_ID field is specified: {} ({}#cpe-id)".format(
                        self.filename,
                        self.valid["lineno"],
                        self.valid["text"],
                        self.url_to_manual,
            )]

    def _check_field(self, lineno, text, field, var, val):
        if field == "VERSION" and self.CPE_fields_defaults[field] is None:
            return ["{}:{}: expecting package version to be set before CPE_ID_VERSION".format(
                self.filename,
                lineno,
            )]
        if val == self.CPE_fields_defaults[field]:
            return ["{}:{}: '{}' is the default value for {} ({}#cpe-id)".format(
                self.filename,
                lineno,
                val,
                var,
                self.url_to_manual,
            )]
        else:
            if field == "VALID":
                self.valid = {"lineno": lineno, "text": text}
            self.non_defaults += 1
