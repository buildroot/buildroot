import pytest
import checkpackagelib.test_util as util
import checkpackagelib.lib_config as m


AttributesOrder = [
    ('good example',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'default y\n'
     'depends on BR2_USE_BAR # runtime\n'
     'select BR2_PACKAGE_BAZ\n'
     'help\n'
     '\t  help text\n',
     []),
    ('depends before default',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'depends on BR2_USE_BAR\n'
     'default y\n',
     [['any:4: attributes order: type, default, depends on, select, help (url#_config_files)',
       'default y\n']]),
    ('select after help',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'help\n'
     '\t  help text\n'
     'select BR2_PACKAGE_BAZ\n',
     [['any:5: attributes order: type, default, depends on, select, help (url#_config_files)',
       'select BR2_PACKAGE_BAZ\n']]),
    ('string',
     'any',
     'config BR2_PACKAGE_FOO_PLUGINS\n'
     'string "foo plugins"\n'
     'default "all"\n',
     []),
    ('ignore tabs',
     'any',
     'config\tBR2_PACKAGE_FOO_PLUGINS\n'
     'default\t"all"\n'
     'string\t"foo plugins"\n',
     [['any:3: attributes order: type, default, depends on, select, help (url#_config_files)',
       'string\t"foo plugins"\n']]),
    ('choice',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'if BR2_PACKAGE_FOO\n'
     '\n'
     'choice\n'
     'prompt "type of foo"\n'
     'default BR2_PACKAGE_FOO_STRING\n'
     '\n'
     'config BR2_PACKAGE_FOO_NONE\n'
     'bool "none"\n'
     '\n'
     'config BR2_PACKAGE_FOO_STRING\n'
     'bool "string"\n'
     '\n'
     'endchoice\n'
     '\n'
     'endif\n'
     '\n',
     []),
    ('type after default',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'if BR2_PACKAGE_FOO\n'
     '\n'
     'choice\n'
     'default BR2_PACKAGE_FOO_STRING\n'
     'prompt "type of foo"\n',
     [['any:7: attributes order: type, default, depends on, select, help (url#_config_files)',
       'prompt "type of foo"\n']]),
    ('menu',
     'any',
     'menuconfig BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'help\n'
     '\t  help text\n'
     '\t  help text\n'
     '\n'
     'if BR2_PACKAGE_FOO\n'
     '\n'
     'menu "foo plugins"\n'
     'config BR2_PACKAGE_FOO_COUNTER\n'
     'bool "counter"\n'
     '\n'
     'endmenu\n'
     '\n'
     'endif\n',
     []),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', AttributesOrder)
def test_AttributesOrder(testname, filename, string, expected):
    warnings = util.check_file(m.AttributesOrder, filename, string)
    assert warnings == expected


CommentsMenusPackagesOrder = [
    ('top menu (good)',
     'package/Config.in',
     'menu "Target packages"\n'
     'source "package/busybox/Config.in"\n'
     'source "package/skeleton/Config.in"\n',
     []),
    ('top menu (bad)',
     'package/Config.in',
     'source "package/skeleton/Config.in"\n'
     'source "package/busybox/Config.in"\n',
     [['package/Config.in:2: Packages in: The top level menu,\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: busybox',
       'source "package/busybox/Config.in"\n']]),
    ('menu (bad)',
     'package/Config.in',
     'menu "Target packages"\n'
     'source "package/skeleton/Config.in"\n'
     'source "package/busybox/Config.in"\n',
     [['package/Config.in:3: Packages in: menu "Target packages",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: busybox',
       'source "package/busybox/Config.in"\n']]),
    ('underscore (good)',
     'package/Config.in.host',
     'menu "Hardware handling"\n'
     'menu "Firmware"\n'
     'endmenu\n'
     'source "package/usb_modeswitch/Config.in"\n'
     'source "package/usbmount/Config.in"\n',
     []),
    ('underscore (bad)',
     'package/Config.in.host',
     'menu "Hardware handling"\n'
     'menu "Firmware"\n'
     'endmenu\n'
     'source "package/usbmount/Config.in"\n'
     'source "package/usb_modeswitch/Config.in"\n',
     [['package/Config.in.host:5: Packages in: menu "Hardware handling",\n'
       '                          are not alphabetically ordered;\n'
       "                          correct order: '-', '_', digits, capitals, lowercase;\n"
       '                          first incorrect package: usb_modeswitch',
       'source "package/usb_modeswitch/Config.in"\n']]),
    ('ignore other files',
     'any other file',
     'menu "Hardware handling"\n'
     'source "package/bbb/Config.in"\n'
     'source "package/aaa/Config.in"\n',
     []),
    ('dash (bad)',
     'package/Config.in',
     'menu "packages"\n'
     'source "package/a_a/Config.in"\n'
     'source "package/a-a/Config.in"\n'
     'source "package/a1a/Config.in"\n'
     'source "package/aAa/Config.in"\n'
     'source "package/aaa/Config.in"\n',
     [['package/Config.in:3: Packages in: menu "packages",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: a-a',
       'source "package/a-a/Config.in"\n']]),
    ('underscore (bad)',
     'package/Config.in',
     'menu "packages"\n'
     'source "package/a-a/Config.in"\n'
     'source "package/a1a/Config.in"\n'
     'source "package/a_a/Config.in"\n'
     'source "package/aAa/Config.in"\n'
     'source "package/aaa/Config.in"\n',
     [['package/Config.in:4: Packages in: menu "packages",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: a_a',
       'source "package/a_a/Config.in"\n']]),
    ('digit (bad)',
     'package/Config.in',
     'menu "packages"\n'
     'source "package/a-a/Config.in"\n'
     'source "package/a_a/Config.in"\n'
     'source "package/aAa/Config.in"\n'
     'source "package/a1a/Config.in"\n'
     'source "package/aaa/Config.in"\n',
     [['package/Config.in:5: Packages in: menu "packages",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: a1a',
       'source "package/a1a/Config.in"\n']]),
    ('capitals (bad)',
     'package/Config.in',
     'menu "packages"\n'
     'source "package/a-a/Config.in"\n'
     'source "package/a_a/Config.in"\n'
     'source "package/a1a/Config.in"\n'
     'source "package/aaa/Config.in"\n'
     'source "package/aAa/Config.in"\n',
     [['package/Config.in:6: Packages in: menu "packages",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: aAa',
       'source "package/aAa/Config.in"\n']]),
    ('digits, capitals, underscore (good)',
     'package/Config.in',
     'menu "packages"\n'
     'source "package/a-a/Config.in"\n'
     'source "package/a_a/Config.in"\n'
     'source "package/a1a/Config.in"\n'
     'source "package/aAa/Config.in"\n'
     'source "package/aaa/Config.in"\n',
     []),
    ('conditional menu (good)',
     'package/Config.in',
     'menu "Other"\n'
     'source "package/linux-pam/Config.in"\n'
     'if BR2_PACKAGE_LINUX_PAM\n'
     'comment "linux-pam plugins"\n'
     'source "package/libpam-radius-auth/Config.in"\n'
     'source "package/libpam-tacplus/Config.in"\n'
     'endif\n'
     'source "package/liquid-dsp/Config.in"\n',
     []),
    ('conditional menu (bad)',
     'package/Config.in',
     'menu "Other"\n'
     'source "package/linux-pam/Config.in"\n'
     'if BR2_PACKAGE_LINUX_PAM\n'
     'comment "linux-pam plugins"\n'
     'source "package/libpam-tacplus/Config.in"\n'
     'source "package/libpam-radius-auth/Config.in"\n'
     'endif\n'
     'source "package/liquid-dsp/Config.in"\n',
     [['package/Config.in:6: Packages in: comment "linux-pam plugins",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: libpam-radius-auth',
       'source "package/libpam-radius-auth/Config.in"\n']]),
    ('no conditional (bad)',
     'package/Config.in',
     'menu "Other"\n'
     'source "package/linux-pam/Config.in"\n'
     'source "package/libpam-radius-auth/Config.in"\n'
     'source "package/libpam-tacplus/Config.in"\n'
     'source "package/liquid-dsp/Config.in"\n',
     [['package/Config.in:3: Packages in: menu "Other",\n'
       '                     are not alphabetically ordered;\n'
       "                     correct order: '-', '_', digits, capitals, lowercase;\n"
       '                     first incorrect package: libpam-radius-auth',
       'source "package/libpam-radius-auth/Config.in"\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', CommentsMenusPackagesOrder)
def test_CommentsMenusPackagesOrder(testname, filename, string, expected):
    warnings = util.check_file(m.CommentsMenusPackagesOrder, filename, string)
    assert warnings == expected


HelpText = [
    ('single line',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'default y\n'
     'depends on BR2_USE_BAR # runtime\n'
     'select BR2_PACKAGE_BAZ\n'
     'help\n'
     '\t  help text\n',
     []),
    ('larger than 72',
     'any',
     'help\n'
     '\t  123456789 123456789 123456789 123456789 123456789 123456789 12\n'
     '\t  123456789 123456789 123456789 123456789 123456789 123456789 123\n'
     '\t  help text\n',
     [['any:3: help text: <tab><2 spaces><62 chars> (url#writing-rules-config-in)',
       '\t  123456789 123456789 123456789 123456789 123456789 123456789 123\n',
       '\t  123456789 123456789 123456789 123456789 123456789 123456789 12']]),
    ('long url at beginning of line',
     'any',
     'help\n'
     '\t  123456789 123456789 123456789 123456789 123456789 123456789 12\n'
     '\t  http://url.that.is.longer.than.seventy.two.characthers/folder_name\n'
     '\t  https://url.that.is.longer.than.seventy.two.characthers/folder_name\n'
     '\t  git://url.that.is.longer.than.seventy.two.characthers/folder_name\n',
     []),
    ('long url not at beginning of line',
     'any',
     'help\n'
     '\t  123456789 123456789 123456789 123456789 123456789 123456789 12\n'
     '\t  refer to http://url.that.is.longer.than.seventy.two.characthers/folder_name\n'
     '\n'
     '\t  http://url.that.is.longer.than.seventy.two.characthers/folder_name\n',
     [['any:3: help text: <tab><2 spaces><62 chars> (url#writing-rules-config-in)',
       '\t  refer to http://url.that.is.longer.than.seventy.two.characthers/folder_name\n',
       '\t  123456789 123456789 123456789 123456789 123456789 123456789 12']]),
    ('allow beautified items',
     'any',
     'help\n'
     '\t  123456789 123456789 123456789 123456789 123456789 123456789 12\n'
     '\t  summary:\n'
     '\t    - enable that config\n'
     '\t    - built it\n',
     []),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', HelpText)
def test_HelpText(testname, filename, string, expected):
    warnings = util.check_file(m.HelpText, filename, string)
    assert warnings == expected


Indent = [
    ('good example',
     'any',
     'config BR2_PACKAGE_FOO\n'
     '\tbool "foo"\n'
     '\tdefault y\n'
     '\tdepends on BR2_TOOLCHAIN_HAS_THREADS\n'
     '\tdepends on BR2_INSTALL_LIBSTDCPP\n'
     '# very useful comment\n'
     '\tselect BR2_PACKAGE_BAZ\n'
     '\thelp\n'
     '\t  help text\n'
     '\n'
     'comment "foo needs toolchain w/ C++, threads"\n'
     '\tdepends on !BR2_INSTALL_LIBSTDCPP || \\\n'
     '\t\t!BR2_TOOLCHAIN_HAS_THREADS\n'
     '\n'
     'source "package/foo/bar/Config.in"\n',
     []),
    ('spaces',
     'any',
     'config BR2_PACKAGE_FOO\n'
     '        bool "foo"\n',
     [['any:2: should be indented with one tab (url#_config_files)',
       '        bool "foo"\n']]),
    ('without indent',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'default y\n',
     [['any:2: should be indented with one tab (url#_config_files)',
       'default y\n']]),
    ('too much tabs',
     'any',
     'config BR2_PACKAGE_FOO\n'
     '\t\tdepends on BR2_TOOLCHAIN_HAS_THREADS\n',
     [['any:2: should be indented with one tab (url#_config_files)',
       '\t\tdepends on BR2_TOOLCHAIN_HAS_THREADS\n']]),
    ('help',
     'any',
     'config BR2_PACKAGE_FOO\n'
     '     help\n',
     [['any:2: should be indented with one tab (url#_config_files)',
       '     help\n']]),
    ('continuation line',
     'any',
     'comment "foo needs toolchain w/ C++, threads"\n'
     '\tdepends on !BR2_INSTALL_LIBSTDCPP || \\\n'
     '                !BR2_TOOLCHAIN_HAS_THREADS\n',
     [['any:3: continuation line should be indented using tabs',
       '                !BR2_TOOLCHAIN_HAS_THREADS\n']]),
    ('comment with tabs',
     'any',
     '\tcomment "foo needs toolchain w/ C++, threads"\n',
     [['any:1: should not be indented',
       '\tcomment "foo needs toolchain w/ C++, threads"\n']]),
    ('comment with spaces',
     'any',
     '  comment "foo needs toolchain w/ C++, threads"\n',
     [['any:1: should not be indented',
       '  comment "foo needs toolchain w/ C++, threads"\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Indent)
def test_Indent(testname, filename, string, expected):
    warnings = util.check_file(m.Indent, filename, string)
    assert warnings == expected


RedefinedConfig = [
    ('no redefinition',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'config BR2_PACKAGE_FOO_BAR\n'
     'bool "foo"\n',
     []),
    ('no conditional',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'config BR2_PACKAGE_BAR\n'
     'bool "bar"\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n',
     [['any:5: config BR2_PACKAGE_FOO redeclared (previous line: 1)',
       'config BR2_PACKAGE_FOO\n']]),
    ('three times',
     'any',
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n',
     [['any:3: config BR2_PACKAGE_FOO redeclared (previous line: 1)',
       'config BR2_PACKAGE_FOO\n'],
      ['any:5: config BR2_PACKAGE_FOO redeclared (previous line: 1)',
       'config BR2_PACKAGE_FOO\n']]),
    ('same conditional',
     'any',
     'if BR2_PACKAGE_BAZ\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'config BR2_PACKAGE_BAR\n'
     'bool "bar"\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'endif\n',
     [['any:6: config BR2_PACKAGE_FOO redeclared (previous line: 2)',
       'config BR2_PACKAGE_FOO\n']]),
    ('equivalent conditional',
     'any',
     'if BR2_PACKAGE_BAZ\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'endif\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'if BR2_PACKAGE_BAZ\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'endif\n',
     [['any:8: config BR2_PACKAGE_FOO redeclared (previous line: 2)',
       'config BR2_PACKAGE_FOO\n']]),
    ('not equivalent conditional',
     'any',
     'if BR2_PACKAGE_BAZ\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'endif\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'if !BR2_PACKAGE_BAZ\n'
     'config BR2_PACKAGE_FOO\n'
     'bool "foo"\n'
     'endif\n',
     []),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', RedefinedConfig)
def test_RedefinedConfig(testname, filename, string, expected):
    warnings = util.check_file(m.RedefinedConfig, filename, string)
    assert warnings == expected
