import pytest
import checkpackagelib.test_util as util
import checkpackagelib.lib_mk as m


Indent = [
    ('ignore comment at beginning of line',
     'any',
     '# very useful comment\n',
     []),
    ('ignore comment at end of line',
     'any',
     ' # very useful comment\n',
     []),
    ('do not indent on conditional (good)',
     'any',
     'ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)\n'
     'FOO_CONF_OPTS += something\n'
     'endef\n',
     []),
    ('do not indent on conditional (bad)',
     'any',
     'ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)\n'
     '\tFOO_CONF_OPTS += something\n'
     'endef\n',
     [['any:2: unexpected indent with tabs',
       '\tFOO_CONF_OPTS += something\n']]),
    ('indent after line that ends in backslash (good)',
     'any',
     'FOO_CONF_OPTS += \\\n'
     '\tsomething\n',
     []),
    ('indent after line that ends in backslash (bad)',
     'any',
     'FOO_CONF_OPTS += \\\n'
     'something\n',
     [['any:2: expected indent with tabs',
       'something\n']]),
    ('indent after 2 lines that ends in backslash (good)',
     'any',
     'FOO_CONF_OPTS += \\\n'
     '\tsomething \\\n'
     '\tsomething_else\n',
     []),
    ('indent after 2 lines that ends in backslash (bad)',
     'any',
     'FOO_CONF_OPTS += \\\n'
     '\tsomething \\\n'
     '\tsomething_else \\\n'
     'FOO_CONF_OPTS += another_thing\n',
     [['any:4: expected indent with tabs',
       'FOO_CONF_OPTS += another_thing\n']]),
    ('indent inside define (good)',
     'any',
     'define FOO_SOMETHING\n'
     '\tcommand\n'
     '\tcommand \\\n'
     '\t\targuments\n'
     'endef\n'
     'FOO_POST_PATCH_HOOKS += FOO_SOMETHING\n',
     []),
    ('indent inside define (bad, no indent)',
     'any',
     'define FOO_SOMETHING\n'
     'command\n'
     'endef\n',
     [['any:2: expected indent with tabs',
       'command\n']]),
    ('indent inside define (bad, spaces)',
     'any',
     'define FOO_SOMETHING\n'
     '        command\n'
     'endef\n',
     [['any:2: expected indent with tabs',
       '        command\n']]),
    ('indent make target (good)',
     'any',
     'make_target:\n'
     '\tcommand\n'
     '\n',
     []),
    ('indent make target (bad)',
     'any',
     'make_target:\n'
     '        command\n'
     '\n',
     [['any:2: expected indent with tabs',
       '        command\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Indent)
def test_Indent(testname, filename, string, expected):
    warnings = util.check_file(m.Indent, filename, string)
    assert warnings == expected


OverriddenVariable = [
    ('simple assignment',
     'any.mk',
     'VAR_1 = VALUE1\n',
     []),
    ('unconditional override (variable without underscore)',
     'any.mk',
     'VAR1 = VALUE1\n'
     'VAR1 = VALUE1\n',
     [['any.mk:2: unconditional override of variable VAR1',
       'VAR1 = VALUE1\n']]),
    ('unconditional override (variable with underscore, same value)',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'VAR_1 = VALUE1\n',
     [['any.mk:2: unconditional override of variable VAR_1',
       'VAR_1 = VALUE1\n']]),
    ('unconditional override (variable with underscore, different value)',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'VAR_1 = VALUE2\n',
     [['any.mk:2: unconditional override of variable VAR_1',
       'VAR_1 = VALUE2\n']]),
    ('warn for unconditional override even with wrong number of spaces',
     'any.mk',
     'VAR_1= VALUE1\n'
     'VAR_1 =VALUE2\n',
     [['any.mk:2: unconditional override of variable VAR_1',
       'VAR_1 =VALUE2\n']]),
    ('warn for := override',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'VAR_1 := VALUE2\n',
     [['any.mk:2: unconditional override of variable VAR_1',
       'VAR_1 := VALUE2\n']]),
    ('append values outside conditional (good)',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'VAR_1 += VALUE2\n',
     []),
    ('append values outside conditional (bad)',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'VAR_1 := $(VAR_1), VALUE2\n',
     [['any.mk:2: unconditional override of variable VAR_1',
       'VAR_1 := $(VAR_1), VALUE2\n']]),
    ('immediate assignment inside conditional',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'ifeq (condition)\n'
     'VAR_1 := $(VAR_1), VALUE2\n',
     [['any.mk:3: immediate assignment to append to variable VAR_1',
       'VAR_1 := $(VAR_1), VALUE2\n']]),
    ('immediate assignment inside conditional and unconditional override outside',
     'any.mk',
     'VAR_1 = VALUE1\n'
     'ifeq (condition)\n'
     'VAR_1 := $(VAR_1), VALUE2\n'
     'endif\n'
     'VAR_1 := $(VAR_1), VALUE2\n',
     [['any.mk:3: immediate assignment to append to variable VAR_1',
       'VAR_1 := $(VAR_1), VALUE2\n'],
      ['any.mk:5: unconditional override of variable VAR_1',
       'VAR_1 := $(VAR_1), VALUE2\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', OverriddenVariable)
def test_OverriddenVariable(testname, filename, string, expected):
    warnings = util.check_file(m.OverriddenVariable, filename, string)
    assert warnings == expected


PackageHeader = [
    ('first line (good)',
     'any',
     80 * '#' + '\n',
     []),
    ('first line (bad)',
     'any',
     '# very useful comment\n',
     [['any:1: should be 80 hashes (url#writing-rules-mk)',
       '# very useful comment\n',
       80 * '#']]),
    ('second line (bad)',
     'any',
     80 * '#' + '\n'
     '# package\n',
     [['any:2: should be 1 hash (url#writing-rules-mk)',
       '# package\n']]),
    ('full header (good)',
     'any',
     80 * '#' + '\n'
     '#\n'
     '# package\n'
     '#\n' +
     80 * '#' + '\n'
     '\n',
     []),
    ('blank line after header (good)',
     'any',
     80 * '#' + '\n'
     '#\n'
     '# package\n'
     '#\n' +
     80 * '#' + '\n'
     '\n'
     'FOO_VERSION = 1\n',
     []),
    ('blank line after header (bad)',
     'any',
     80 * '#' + '\n'
     '#\n'
     '# package\n'
     '#\n' +
     80 * '#' + '\n'
     'FOO_VERSION = 1\n',
     [['any:6: should be a blank line (url#writing-rules-mk)',
       'FOO_VERSION = 1\n']]),
    ('wrong number of hashes',
     'any',
     79 * '#' + '\n'
     '#\n'
     '# package\n'
     '#\n' +
     81 * '#' + '\n'
     '\n',
     [['any:1: should be 80 hashes (url#writing-rules-mk)',
       79 * '#' + '\n',
       80 * '#'],
      ['any:5: should be 80 hashes (url#writing-rules-mk)',
       81 * '#' + '\n',
       80 * '#']]),
    ('allow include without header',
     'any',
     'include $(sort $(wildcard package/foo/*/*.mk))\n',
     []),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', PackageHeader)
def test_PackageHeader(testname, filename, string, expected):
    warnings = util.check_file(m.PackageHeader, filename, string)
    assert warnings == expected


RemoveDefaultPackageSourceVariable = [
    ('bad',
     'any.mk',
     'ANY_SOURCE = any-$(ANY_VERSION).tar.gz\n',
     [['any.mk:1: remove default value of _SOURCE variable (url#generic-package-reference)',
       'ANY_SOURCE = any-$(ANY_VERSION).tar.gz\n']]),
    ('bad with path',
     './any.mk',
     'ANY_SOURCE = any-$(ANY_VERSION).tar.gz\n',
     [['./any.mk:1: remove default value of _SOURCE variable (url#generic-package-reference)',
       'ANY_SOURCE = any-$(ANY_VERSION).tar.gz\n']]),
    ('warn for correct line',
     './any.mk',
     '\n'
     '\n'
     '\n'
     'ANY_SOURCE = any-$(ANY_VERSION).tar.gz\n',
     [['./any.mk:4: remove default value of _SOURCE variable (url#generic-package-reference)',
       'ANY_SOURCE = any-$(ANY_VERSION).tar.gz\n']]),
    ('warn ignoring missing spaces',
     './any.mk',
     'ANY_SOURCE=any-$(ANY_VERSION).tar.gz\n',
     [['./any.mk:1: remove default value of _SOURCE variable (url#generic-package-reference)',
       'ANY_SOURCE=any-$(ANY_VERSION).tar.gz\n']]),
    ('good',
     './any.mk',
     'ANY_SOURCE = aNy-$(ANY_VERSION).tar.gz\n',
     []),
    ('gcc exception',
     'gcc.mk',
     'GCC_SOURCE = gcc-$(GCC_VERSION).tar.gz\n',
     []),
    ('binutils exception',
     './binutils.mk',
     'BINUTILS_SOURCE = binutils-$(BINUTILS_VERSION).tar.gz\n',
     []),
    ('gdb exception',
     'gdb/gdb.mk',
     'GDB_SOURCE = gdb-$(GDB_VERSION).tar.gz\n',
     []),
    ('package name with dash',
     'python-subprocess32.mk',
     'PYTHON_SUBPROCESS32_SOURCE = python-subprocess32-$(PYTHON_SUBPROCESS32_VERSION).tar.gz\n',
     [['python-subprocess32.mk:1: remove default value of _SOURCE variable (url#generic-package-reference)',
       'PYTHON_SUBPROCESS32_SOURCE = python-subprocess32-$(PYTHON_SUBPROCESS32_VERSION).tar.gz\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', RemoveDefaultPackageSourceVariable)
def test_RemoveDefaultPackageSourceVariable(testname, filename, string, expected):
    warnings = util.check_file(m.RemoveDefaultPackageSourceVariable, filename, string)
    assert warnings == expected


SpaceBeforeBackslash = [
    ('no backslash',
     'any.mk',
     '\n',
     []),
    ('ignore missing indent',
     'any.mk',
     'define ANY_SOME_FIXUP\n'
     'for i in $$(find $(STAGING_DIR)/usr/lib* -name "any*.la"); do \\\n',
     []),
    ('ignore missing space',
     'any.mk',
     'ANY_CONF_ENV= \\\n'
     '\tap_cv_void_ptr_lt_long=no \\\n',
     []),
    ('variable',
     'any.mk',
     '\n'
     'ANY = \\\n',
     []),
    ('2 spaces',
     'any.mk',
     'ANY =  \\\n',
     [['any.mk:1: use only one space before backslash',
       'ANY =  \\\n']]),
    ('warn about correct line',
     'any.mk',
     '\n'
     'ANY =  \\\n',
     [['any.mk:2: use only one space before backslash',
       'ANY =  \\\n']]),
    ('tab',
     'any.mk',
     'ANY =\t\\\n',
     [['any.mk:1: use only one space before backslash',
       'ANY =\t\\\n']]),
    ('tabs',
     'any.mk',
     'ANY =\t\t\\\n',
     [['any.mk:1: use only one space before backslash',
       'ANY =\t\t\\\n']]),
    ('spaces and tabs',
     'any.mk',
     'ANY =  \t\t\\\n',
     [['any.mk:1: use only one space before backslash',
       'ANY =  \t\t\\\n']]),
    ('mixed spaces and tabs 1',
     'any.mk',
     'ANY = \t \t\\\n',
     [['any.mk:1: use only one space before backslash',
       'ANY = \t \t\\\n']]),
    ('mixed spaces and tabs 2',
     'any.mk',
     'ANY = \t  \\\n',
     [['any.mk:1: use only one space before backslash',
       'ANY = \t  \\\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', SpaceBeforeBackslash)
def test_SpaceBeforeBackslash(testname, filename, string, expected):
    warnings = util.check_file(m.SpaceBeforeBackslash, filename, string)
    assert warnings == expected


TrailingBackslash = [
    ('no backslash',
     'any.mk',
     'ANY = \n',
     []),
    ('one line',
     'any.mk',
     'ANY = \\\n',
     []),
    ('2 lines',
     'any.mk',
     'ANY = \\\n'
     '\\\n',
     []),
    ('empty line after',
     'any.mk',
     'ANY = \\\n'
     '\n',
     [['any.mk:1: remove trailing backslash',
       'ANY = \\\n']]),
    ('line with spaces after',
     'any.mk',
     'ANY = \\\n'
     '     \n',
     [['any.mk:1: remove trailing backslash',
       'ANY = \\\n']]),
    ('line with tabs after',
     'any.mk',
     'ANY = \\\n'
     '\t\n',
     [['any.mk:1: remove trailing backslash',
       'ANY = \\\n']]),
    ('ignore if commented',
     'any.mk',
     '# ANY = \\\n'
     '\n',
     []),
    ('real example',
     'any.mk',
     'ANY_CONF_ENV= \t\\\n'
     '\tap_cv_void_ptr_lt_long=no  \\\n'
     '\n',
     [['any.mk:2: remove trailing backslash',
       '\tap_cv_void_ptr_lt_long=no  \\\n']]),
    ('ignore whitespace 1',
     'any.mk',
     'ANY =  \t\t\\\n',
     []),
    ('ignore whitespace 2',
     'any.mk',
     'ANY = \t \t\\\n',
     []),
    ('ignore whitespace 3',
     'any.mk',
     'ANY = \t  \\\n',
     []),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', TrailingBackslash)
def test_TrailingBackslash(testname, filename, string, expected):
    warnings = util.check_file(m.TrailingBackslash, filename, string)
    assert warnings == expected


TypoInPackageVariable = [
    ('good',
     'any.mk',
     'ANY_VAR = \n',
     []),
    ('good with path 1',
     './any.mk',
     'ANY_VAR += \n',
     []),
    ('good with path 2',
     'any/any.mk',
     'ANY_VAR = \n',
     []),
    ('bad =',
     'any.mk',
     'OTHER_VAR = \n',
     [['any.mk:1: possible typo: OTHER_VAR -> *ANY*',
       'OTHER_VAR = \n']]),
    ('bad +=',
     'any.mk',
     'OTHER_VAR += \n',
     [['any.mk:1: possible typo: OTHER_VAR -> *ANY*',
       'OTHER_VAR += \n']]),
    ('ignore missing space',
     'any.mk',
     'OTHER_VAR= \n',
     [['any.mk:1: possible typo: OTHER_VAR -> *ANY*',
       'OTHER_VAR= \n']]),
    ('use path in the warning',
     './any.mk',
     'OTHER_VAR = \n',
     [['./any.mk:1: possible typo: OTHER_VAR -> *ANY*',
       'OTHER_VAR = \n']]),
    ('another name',
     'other.mk',
     'ANY_VAR = \n',
     [['other.mk:1: possible typo: ANY_VAR -> *OTHER*',
       'ANY_VAR = \n']]),
    ('libc exception',
     './any.mk',
     'BR_LIBC = \n',
     []),
    ('rootfs exception',
     'any.mk',
     'ROOTFS_ANY_VAR += \n',
     []),
    ('host (good)',
     'any.mk',
     'HOST_ANY_VAR += \n',
     []),
    ('host (bad)',
     'any.mk',
     'HOST_OTHER_VAR = \n',
     [['any.mk:1: possible typo: HOST_OTHER_VAR -> *ANY*',
       'HOST_OTHER_VAR = \n']]),
    ('provides',
     'any.mk',
     'ANY_PROVIDES = other thing\n'
     'OTHER_VAR = \n',
     []),
    ('ignore space',
     'any.mk',
     'ANY_PROVIDES  =  thing  other \n'
     'OTHER_VAR = \n',
     []),
    ('wrong provides',
     'any.mk',
     'ANY_PROVIDES = other\n'
     'OTHERS_VAR = \n',
     [['any.mk:2: possible typo: OTHERS_VAR -> *ANY*',
       'OTHERS_VAR = \n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', TypoInPackageVariable)
def test_TypoInPackageVariable(testname, filename, string, expected):
    warnings = util.check_file(m.TypoInPackageVariable, filename, string)
    assert warnings == expected


UselessFlag = [
    ('autoreconf no',
     'any.mk',
     'ANY_AUTORECONF=NO\n',
     [['any.mk:1: useless default value (url#_infrastructure_for_autotools_based_packages)',
       'ANY_AUTORECONF=NO\n']]),
    ('host autoreconf no',
     'any.mk',
     'HOST_ANY_AUTORECONF\n',
     []),
    ('autoreconf yes',
     'any.mk',
     'ANY_AUTORECONF=YES\n',
     []),
    ('libtool_patch yes',
     'any.mk',
     'ANY_LIBTOOL_PATCH\t=  YES\n',
     [['any.mk:1: useless default value (url#_infrastructure_for_autotools_based_packages)',
       'ANY_LIBTOOL_PATCH\t=  YES\n']]),
    ('libtool_patch no',
     'any.mk',
     'ANY_LIBTOOL_PATCH= \t NO\n',
     []),
    ('generic',
     'any.mk',
     'ANY_INSTALL_IMAGES = NO\n'
     'ANY_INSTALL_REDISTRIBUTE = YES\n'
     'ANY_INSTALL_STAGING = NO\n'
     'ANY_INSTALL_TARGET = YES\n',
     [['any.mk:1: useless default value (url#_infrastructure_for_packages_with_specific_build_systems)',
       'ANY_INSTALL_IMAGES = NO\n'],
      ['any.mk:2: useless default value (url#_infrastructure_for_packages_with_specific_build_systems)',
       'ANY_INSTALL_REDISTRIBUTE = YES\n'],
      ['any.mk:3: useless default value (url#_infrastructure_for_packages_with_specific_build_systems)',
       'ANY_INSTALL_STAGING = NO\n'],
      ['any.mk:4: useless default value (url#_infrastructure_for_packages_with_specific_build_systems)',
       'ANY_INSTALL_TARGET = YES\n']]),
    ('conditional',
     'any.mk',
     'ifneq (condition)\n'
     'ANY_INSTALL_IMAGES = NO\n'
     'endif\n'
     'ANY_INSTALL_REDISTRIBUTE = YES\n',
     [['any.mk:4: useless default value (url#_infrastructure_for_packages_with_specific_build_systems)',
       'ANY_INSTALL_REDISTRIBUTE = YES\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', UselessFlag)
def test_UselessFlag(testname, filename, string, expected):
    warnings = util.check_file(m.UselessFlag, filename, string)
    assert warnings == expected


VariableWithBraces = [
    ('good',
     'xmlstarlet.mk',
     'XMLSTARLET_CONF_OPTS += \\\n'
     '\t--with-libxml-prefix=$(STAGING_DIR)/usr \\\n',
     []),
    ('bad',
     'xmlstarlet.mk',
     'XMLSTARLET_CONF_OPTS += \\\n'
     '\t--with-libxml-prefix=${STAGING_DIR}/usr \\\n',
     [['xmlstarlet.mk:2: use $() to delimit variables, not ${}',
       '\t--with-libxml-prefix=${STAGING_DIR}/usr \\\n']]),
    ('expanded by the shell',
     'sg3_utils.mk',
     '\tfor prog in xcopy zone; do \\\n'
     '\t\t$(RM) $(TARGET_DIR)/usr/bin/sg_$${prog} ; \\\n'
     '\tdone\n',
     []),
    ('comments',
     'any.mk',
     '#\t--with-libxml-prefix=${STAGING_DIR}/usr \\\n',
     []),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', VariableWithBraces)
def test_VariableWithBraces(testname, filename, string, expected):
    warnings = util.check_file(m.VariableWithBraces, filename, string)
    assert warnings == expected
