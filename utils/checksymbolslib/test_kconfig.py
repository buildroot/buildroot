import pytest
from unittest.mock import Mock
from unittest.mock import call
from checksymbolslib.test_util import assert_db_calls
import checksymbolslib.kconfig as m


all_symbols_from = [
    ('no prefix',
     'config PACKAGE_FOO',
     []),
    ('simple',
     'config BR2_PACKAGE_FOO',
     ['BR2_PACKAGE_FOO']),
    ('ignore comment',
     'config BR2_PACKAGE_FOO # BR2_PACKAGE_BAR',
     ['BR2_PACKAGE_FOO']),
    ('ignore whitespace',
     '\tconfig  BR2_PACKAGE_FOO\t # BR2_PACKAGE_BAR',
     ['BR2_PACKAGE_FOO']),
    ('2 occurrences',
     '\tdefault BR2_PACKAGE_FOO_BAR if BR2_PACKAGE_FOO_BAR != ""',
     ['BR2_PACKAGE_FOO_BAR', 'BR2_PACKAGE_FOO_BAR']),
    ]


@pytest.mark.parametrize('testname,line,expected', all_symbols_from)
def test_all_symbols_from(testname, line, expected):
    symbols = m.all_symbols_from(line)
    assert symbols == expected


handle_definition = [
    ('config',
     'package/foo/Config.in',
     5,
     'config BR2_PACKAGE_FOO',
     False,
     {'add_symbol_definition': [call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5)]}),
    ('ignore comment',
     'package/foo/Config.in',
     5,
     'config BR2_PACKAGE_FOO # BR2_PACKAGE_BAR',
     False,
     {'add_symbol_definition': [call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5)]}),
    ('ignore whitespace',
     'package/foo/Config.in',
     5,
     '\tconfig  BR2_PACKAGE_FOO\t # BR2_PACKAGE_BAR',
     False,
     {'add_symbol_definition': [call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5)]}),
    ('menuconfig',
     'package/gd/Config.in',
     1,
     'menuconfig BR2_PACKAGE_GD',
     False,
     {'add_symbol_definition': [call('BR2_PACKAGE_GD', 'package/gd/Config.in', 1)]}),
    ('menu',
     'package/Config.in',
     100,
     'menu "Database"',
     False,
     {}),
    ('legacy config',
     'Config.in.legacy',
     50,
     'config BR2_PACKAGE_FOO',
     True,
     {'add_symbol_legacy_definition': [call('BR2_PACKAGE_FOO', 'Config.in.legacy', 50)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_definition)
def test_handle_definition(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_definition(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


handle_usage = [
    ('default with comparison',
     'package/openblas/Config.in',
     60,
     '\tdefault y if BR2_PACKAGE_OPENBLAS_DEFAULT_TARGET != ""',
     False,
     {'add_symbol_usage': [call('BR2_PACKAGE_OPENBLAS_DEFAULT_TARGET', 'package/openblas/Config.in', 60)]}),
    ('default with logical operators',
     'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options',
     47,
     '\tdefault y if BR2_i386 && !BR2_x86_i486 && !BR2_x86_i586 && !BR2_x86_x1000 && !BR2_x86_pentium_mmx && !BR2_x86_geode '
     '&& !BR2_x86_c3 && !BR2_x86_winchip_c6 && !BR2_x86_winchip2',
     False,
     {'add_symbol_usage': [
         call('BR2_i386', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_c3', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_geode', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_i486', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_i586', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_pentium_mmx', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_winchip2', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_winchip_c6', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_x1000', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47)]}),
    ('legacy depends on',
     'Config.in.legacy',
     3000,
     '\tdepends on BR2_LINUX_KERNEL',
     True,
     {'add_symbol_usage_in_legacy': [call('BR2_LINUX_KERNEL', 'Config.in.legacy', 3000)]}),
    ('legacy if',
     'Config.in.legacy',
     97,
     'if !BR2_SKIP_LEGACY',
     True,
     {'add_symbol_usage_in_legacy': [call('BR2_SKIP_LEGACY', 'Config.in.legacy', 97)]}),
    ('source',
     'system/Config.in',
     152,
     'source "$BR2_BASE_DIR/.br2-external.in.init"',
     False,
     {'add_symbol_usage': [call('BR2_BASE_DIR', 'system/Config.in', 152)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_usage)
def test_handle_usage(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_usage(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


handle_default = [
    ('default with comparison',
     'package/openblas/Config.in',
     60,
     '\tdefault y if BR2_PACKAGE_OPENBLAS_DEFAULT_TARGET != ""',
     False,
     {'add_symbol_usage': [call('BR2_PACKAGE_OPENBLAS_DEFAULT_TARGET', 'package/openblas/Config.in', 60)]}),
    ('default with logical operators',
     'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options',
     47,
     '\tdefault y if BR2_i386 && !BR2_x86_i486 && !BR2_x86_i586 && !BR2_x86_x1000 && !BR2_x86_pentium_mmx && !BR2_x86_geode '
     '&& !BR2_x86_c3 && !BR2_x86_winchip_c6 && !BR2_x86_winchip2',
     False,
     {'add_symbol_usage': [
         call('BR2_i386', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_c3', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_geode', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_i486', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_i586', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_pentium_mmx', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_winchip2', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_winchip_c6', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47),
         call('BR2_x86_x1000', 'toolchain/toolchain-external/toolchain-external-bootlin/Config.in.options', 47)]}),
    ('legacy default',
     'Config.in.legacy',
     3000,
     'default y if BR2_PACKAGE_REFPOLICY_POLICY_VERSION != ""',
     True,
     {'add_symbol_usage_in_legacy': [call('BR2_PACKAGE_REFPOLICY_POLICY_VERSION', 'Config.in.legacy', 3000)]}),
    ('legacy handling on package',
     'package/uboot-tools/Config.in.host',
     105,
     '\tdefault BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE if BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE != "" # legacy',
     False,
     {'add_symbol_legacy_usage': [call('BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE', 'package/uboot-tools/Config.in.host', 105)]}),
    ('default on package',
     'package/uboot-tools/Config.in.host',
     105,
     '\tdefault BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE if BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE != ""',
     False,
     {'add_symbol_usage': [
         call('BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE', 'package/uboot-tools/Config.in.host', 105),
         call('BR2_TARGET_UBOOT_BOOT_SCRIPT_SOURCE', 'package/uboot-tools/Config.in.host', 105)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_default)
def test_handle_default(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_default(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


handle_select = [
    ('select with comparison',
     'package/bcusdk/Config.in',
     6,
     '\tselect BR2_PACKAGE_ARGP_STANDALONE if BR2_TOOLCHAIN_USES_UCLIBC || BR2_TOOLCHAIN_USES_MUSL',
     False,
     {'add_symbol_select': [call('BR2_PACKAGE_ARGP_STANDALONE', 'package/bcusdk/Config.in', 6)],
      'add_symbol_usage': [
          call('BR2_PACKAGE_ARGP_STANDALONE', 'package/bcusdk/Config.in', 6),
          call('BR2_TOOLCHAIN_USES_UCLIBC', 'package/bcusdk/Config.in', 6),
          call('BR2_TOOLCHAIN_USES_MUSL', 'package/bcusdk/Config.in', 6)]}),
    ('legacy select',
     'Config.in.legacy',
     100,
     '\tselect BR2_PACKAGE_WPA_SUPPLICANT_DBUS if BR2_TOOLCHAIN_HAS_THREADS',
     True,
     {'add_symbol_select': [call('BR2_PACKAGE_WPA_SUPPLICANT_DBUS', 'Config.in.legacy', 100)],
      'add_symbol_usage_in_legacy': [
          call('BR2_PACKAGE_WPA_SUPPLICANT_DBUS', 'Config.in.legacy', 100),
          call('BR2_TOOLCHAIN_HAS_THREADS', 'Config.in.legacy', 100)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_select)
def test_handle_select(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_select(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


handle_line = [
    ('select with comparison',
     'package/bcusdk/Config.in',
     6,
     '\tselect BR2_PACKAGE_ARGP_STANDALONE if BR2_TOOLCHAIN_USES_UCLIBC || BR2_TOOLCHAIN_USES_MUSL',
     False,
     {'add_symbol_select': [call('BR2_PACKAGE_ARGP_STANDALONE', 'package/bcusdk/Config.in', 6)],
      'add_symbol_usage': [
         call('BR2_PACKAGE_ARGP_STANDALONE', 'package/bcusdk/Config.in', 6),
         call('BR2_TOOLCHAIN_USES_UCLIBC', 'package/bcusdk/Config.in', 6),
         call('BR2_TOOLCHAIN_USES_MUSL', 'package/bcusdk/Config.in', 6)]}),
    ('legacy select',
     'Config.in.legacy',
     100,
     '\tselect BR2_PACKAGE_WPA_SUPPLICANT_DBUS if BR2_TOOLCHAIN_HAS_THREADS',
     True,
     {'add_symbol_select': [call('BR2_PACKAGE_WPA_SUPPLICANT_DBUS', 'Config.in.legacy', 100)],
      'add_symbol_usage_in_legacy': [
          call('BR2_PACKAGE_WPA_SUPPLICANT_DBUS', 'Config.in.legacy', 100),
          call('BR2_TOOLCHAIN_HAS_THREADS', 'Config.in.legacy', 100)]}),
    ('comment with symbol',
     'Config.in',
     6,
     '\tselect # BR2_PACKAGE_ARGP_STANDALONE if BR2_TOOLCHAIN_USES_UCLIBC || BR2_TOOLCHAIN_USES_MUSL',
     False,
     {}),
    ('comment',
     'Config.in',
     6,
     '# just a comment',
     False,
     {}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_line)
def test_handle_line(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_line(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


handle_config_helper = [
    ('no select',
     'package/foo/Config.in',
     [[5, 'config BR2_PACKAGE_FOO']],
     {}),
    ('select',
     'package/foo/Config.in',
     [[5, 'config BR2_PACKAGE_FOO'],
      [6, '\tselect BR2_PACKAGE_BAR']],
     {'add_symbol_helper': [call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5)]}),
    ('ignore comment',
     'package/foo/Config.in',
     [[5, 'config BR2_PACKAGE_FOO # BR2_PACKAGE_BAR'],
      [6, '\tselect BR2_PACKAGE_BAR # BR2_PACKAGE_FOO']],
     {'add_symbol_helper': [call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5)]}),
    ('correct symbol',
     'package/foo/Config.in',
     [[5, 'config BR2_PACKAGE_FOO'],
      [6, 'config BR2_PACKAGE_BAR'],
      [7, '\tselect BR2_PACKAGE_BAZ']],
     {'add_symbol_helper': [call('BR2_PACKAGE_BAR', 'package/foo/Config.in', 6)]}),
    ('2 selects',
     'package/foo/Config.in',
     [[5, 'config BR2_PACKAGE_FOO'],
      [6, '\tselect BR2_PACKAGE_BAR'],
      [7, ' select BR2_PACKAGE_BAR']],
     {'add_symbol_helper': [call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5)]}),
    ]


@pytest.mark.parametrize('testname,filename,file_content,expected_calls', handle_config_helper)
def test_handle_config_helper(testname, filename, file_content, expected_calls):
    db = Mock()
    m.handle_config_helper(db, filename, file_content)
    assert_db_calls(db, expected_calls)


handle_config_choice = [
    ('no choice',
     'package/foo/Config.in',
     [[5, 'config BR2_PACKAGE_FOO']],
     {}),
    ('after',
     'package/foo/Config.in',
     [[3, 'choice'],
      [4, '\tprompt "your choice"'],
      [5, 'config BR2_PACKAGE_FOO'],
      [6, 'config BR2_PACKAGE_BAR'],
      [10, 'endchoice'],
      [19, 'config BR2_PACKAGE_BAZ']],
     {'add_symbol_choice': [
         call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5),
         call('BR2_PACKAGE_BAR', 'package/foo/Config.in', 6)]}),
    ('before',
     'package/foo/Config.in',
     [[1, 'config BR2_PACKAGE_BAZ'],
      [3, 'choice'],
      [4, '\tprompt "your choice"'],
      [5, 'config BR2_PACKAGE_FOO'],
      [6, 'config BR2_PACKAGE_BAR'],
      [10, 'endchoice']],
     {'add_symbol_choice': [
         call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5),
         call('BR2_PACKAGE_BAR', 'package/foo/Config.in', 6)]}),
    ]


@pytest.mark.parametrize('testname,filename,file_content,expected_calls', handle_config_choice)
def test_handle_config_choice(testname, filename, file_content, expected_calls):
    db = Mock()
    m.handle_config_choice(db, filename, file_content)
    assert_db_calls(db, expected_calls)


handle_note = [
    ('example',
     'Config.in.legacy',
     [[51, '#   # Note: BR2_FOO_1 is still referenced from package/foo/Config.in']],
     {}),
    ('ok',
     'Config.in.legacy',
     [[112, 'menu "Legacy config options"'],
      [2132, '# Note: BR2_PACKAGE_FOO is still referenced from package/foo/Config.in'],
      [4958, 'endmenu']],
     {'add_symbol_legacy_note': [call('BR2_PACKAGE_FOO', 'Config.in.legacy', 2132)]}),
    ('before and after',
     'Config.in.legacy',
     [[100, '# Note: BR2_PACKAGE_BAR is still referenced from package/foo/Config.in'],
      [112, 'menu "Legacy config options"'],
      [2132, '# Note: BR2_PACKAGE_FOO is still referenced from package/foo/Config.in'],
      [4958, 'endmenu'],
      [5000, '# Note: BR2_PACKAGE_BAR is still referenced from package/foo/Config.in']],
     {'add_symbol_legacy_note': [call('BR2_PACKAGE_FOO', 'Config.in.legacy', 2132)]}),
    ]


@pytest.mark.parametrize('testname,filename,file_content,expected_calls', handle_note)
def test_handle_note(testname, filename, file_content, expected_calls):
    db = Mock()
    m.handle_note(db, filename, file_content)
    assert_db_calls(db, expected_calls)


populate_db = [
    ('legacy',
     'Config.in.legacy',
     [[112, 'menu "Legacy config options"'],
      [2100, 'config BR2_PACKAGE_FOO'],
      [2101, '\tselect BR2_PACKAGE_BAR'],
      [2132, '# Note: BR2_PACKAGE_FOO is still referenced from package/foo/Config.in'],
      [4958, 'endmenu']],
     {'add_symbol_legacy_note': [call('BR2_PACKAGE_FOO', 'Config.in.legacy', 2132)],
      'add_symbol_helper': [call('BR2_PACKAGE_FOO', 'Config.in.legacy', 2100)],
      'add_symbol_legacy_definition': [call('BR2_PACKAGE_FOO', 'Config.in.legacy', 2100)],
      'add_symbol_usage_in_legacy': [call('BR2_PACKAGE_BAR', 'Config.in.legacy', 2101)],
      'add_symbol_select': [call('BR2_PACKAGE_BAR', 'Config.in.legacy', 2101)]}),
    ('normal',
     'package/foo/Config.in',
     [[1, 'config BR2_PACKAGE_BAZ'],
      [3, 'choice'],
      [4, '\tprompt "your choice"'],
      [5, 'config BR2_PACKAGE_FOO'],
      [6, 'config BR2_PACKAGE_BAR'],
      [7, '\t select BR2_PACKAGE_FOO_BAR'],
      [10, 'endchoice']],
     {'add_symbol_choice': [
         call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5),
         call('BR2_PACKAGE_BAR', 'package/foo/Config.in', 6)],
      'add_symbol_usage': [
         call('BR2_PACKAGE_FOO_BAR', 'package/foo/Config.in', 7)],
      'add_symbol_select': [
         call('BR2_PACKAGE_FOO_BAR', 'package/foo/Config.in', 7)],
      'add_symbol_definition': [
         call('BR2_PACKAGE_BAZ', 'package/foo/Config.in', 1),
         call('BR2_PACKAGE_FOO', 'package/foo/Config.in', 5),
         call('BR2_PACKAGE_BAR', 'package/foo/Config.in', 6)],
      'add_symbol_helper': [
         call('BR2_PACKAGE_BAR', 'package/foo/Config.in', 6)]}),
    ]


@pytest.mark.parametrize('testname,filename,file_content,expected_calls', populate_db)
def test_populate_db(testname, filename, file_content, expected_calls):
    db = Mock()
    m.populate_db(db, filename, file_content)
    assert_db_calls(db, expected_calls)


check_filename = [
    ('Config.in',
     'Config.in',
     True),
    ('Config.in.legacy',
     'Config.in.legacy',
     True),
    ('arch/Config.in.microblaze',
     'arch/Config.in.microblaze',
     True),
    ('package/php/Config.ext',
     'package/php/Config.ext',
     True),
    ('package/pru-software-support/Config.in.host',
     'package/pru-software-support/Config.in.host',
     True),
    ('toolchain/toolchain-external/toolchain-external-custom/Config.in.options',
     'toolchain/toolchain-external/toolchain-external-custom/Config.in.options',
     True),
    ('package/foo/0001-Config.patch',
     'package/foo/0001-Config.patch',
     False),
    ('package/pkg-generic.mk',
     'package/pkg-generic.mk',
     False),
    ('Makefile',
     'Makefile',
     False),
    ]


@pytest.mark.parametrize('testname,filename,expected', check_filename)
def test_check_filename(testname, filename, expected):
    symbols = m.check_filename(filename)
    assert symbols == expected
