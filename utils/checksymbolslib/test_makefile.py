import pytest
from unittest.mock import Mock
from unittest.mock import call
from checksymbolslib.test_util import assert_db_calls
import checksymbolslib.makefile as m


handle_eval = [
    ('generic',
     'package/foo/foo.mk',
     5,
     '$(eval $(generic-package))',
     {'add_symbol_usage': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 5)]}),
    ('ignore trailing whitespace',
     'package/foo/foo.mk',
     5,
     '$(eval $(generic-package)) ',
     {'add_symbol_usage': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 5)]}),
    ('ignore indent',
     'package/foo/foo.mk',
     5,
     '\t$(eval $(generic-package))',
     {'add_symbol_usage': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 5)]}),
    ('rootfs',
     'fs/foo/foo.mk',
     5,
     '$(eval $(rootfs))',
     {'add_symbol_usage': [
         call('BR2_TARGET_ROOTFS_FOO', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_BZIP2', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_GZIP', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_LZ4', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_LZMA', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_LZO', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_XZ', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_ZSTD', 'fs/foo/foo.mk', 5)]}),
    ('kernel module',
     'package/foo/foo.mk',
     6,
     '$(eval $(kernel-module))',
     {'add_symbol_usage': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 6)]}),
    ('not an eval for package infra',
     'docs/manual/manual.mk',
     10,
     '$(eval $(call asciidoc-document))',
     {}),
    ('linux',
     'linux/linux.mk',
     617,
     '$(eval $(kconfig-package))',
     {'add_symbol_usage': [call('BR2_LINUX_KERNEL', 'linux/linux.mk', 617)]}),
    ('virtual toolchain',
     'toolchain/toolchain-external/toolchain-external.mk',
     18,
     '$(eval $(virtual-package))',
     {'add_symbol_usage': [
         call('BR2_PACKAGE_PROVIDES_TOOLCHAIN_EXTERNAL', 'toolchain/toolchain-external/toolchain-external.mk', 18),
         call('BR2_PACKAGE_HAS_TOOLCHAIN_EXTERNAL', 'toolchain/toolchain-external/toolchain-external.mk', 18),
         call('BR2_TOOLCHAIN_EXTERNAL', 'toolchain/toolchain-external/toolchain-external.mk', 18)],
      'add_symbol_virtual': [call('BR2_TOOLCHAIN_EXTERNAL', 'toolchain/toolchain-external/toolchain-external.mk', 18)]}),
    ('virtual package',
     'package/foo/foo.mk',
     18,
     '$(eval $(virtual-package))',
     {'add_symbol_usage': [
         call('BR2_PACKAGE_PROVIDES_FOO', 'package/foo/foo.mk', 18),
         call('BR2_PACKAGE_HAS_FOO', 'package/foo/foo.mk', 18),
         call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 18)],
      'add_symbol_virtual': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 18)]}),
    ('host virtual package',
     'package/foo/foo.mk',
     18,
     '$(eval $(host-virtual-package))',
     {'add_symbol_usage': [
         call('BR2_PACKAGE_PROVIDES_HOST_FOO', 'package/foo/foo.mk', 18),
         call('BR2_PACKAGE_HAS_HOST_FOO', 'package/foo/foo.mk', 18),
         call('BR2_PACKAGE_HOST_FOO', 'package/foo/foo.mk', 18)]}),
    ('host generic package',
     'package/foo/foo.mk',
     18,
     '$(eval $(host-package))',
     {'add_symbol_usage': [call('BR2_PACKAGE_HOST_FOO', 'package/foo/foo.mk', 18)]}),
    ('boot package',
     'boot/foo/foo.mk',
     18,
     '$(eval $(generic-package))',
     {'add_symbol_usage': [call('BR2_TARGET_FOO', 'boot/foo/foo.mk', 18)]}),
    ('toolchain package',
     'toolchain/foo/foo.mk',
     18,
     '$(eval $(generic-package))',
     {'add_symbol_usage': [call('BR2_FOO', 'toolchain/foo/foo.mk', 18)]}),
    ('generic package',
     'package/foo/foo.mk',
     18,
     '$(eval $(generic-package))',
     {'add_symbol_usage': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 18)]}),
    ('cmake package',
     'package/foo/foo.mk',
     18,
     '$(eval $(cmake-package))',
     {'add_symbol_usage': [call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 18)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,expected_calls', handle_eval)
def test_handle_eval(testname, filename, lineno, line, expected_calls):
    db = Mock()
    m.handle_eval(db, filename, lineno, line)
    assert_db_calls(db, expected_calls)


handle_definition = [
    ('legacy attribution',
     'Makefile.legacy',
     9,
     'BR2_LEGACY_FOO := foo',
     True,
     {'add_symbol_legacy_definition': [call('BR2_LEGACY_FOO', 'Makefile.legacy', 9)]}),
    ('attribution 1',
     'Makefile',
     9,
     'BR2_FOO ?= foo',
     False,
     {'add_symbol_definition': [call('BR2_FOO', 'Makefile', 9)]}),
    ('attribution 2',
     'Makefile',
     9,
     'BR2_FOO = $(BR2_BAR)',
     False,
     {'add_symbol_definition': [call('BR2_FOO', 'Makefile', 9)]}),
    ('attribution 3',
     'Makefile',
     9,
     'BR2_FOO := foo',
     False,
     {'add_symbol_definition': [call('BR2_FOO', 'Makefile', 9)]}),
    ('normal export',
     'Makefile',
     90,
     'export BR2_FOO',
     False,
     {'add_symbol_definition': [call('BR2_FOO', 'Makefile', 90)]}),
    ('legacy export',
     'Makefile.legacy',
     90,
     'export BR2_FOO',
     True,
     {'add_symbol_legacy_definition': [call('BR2_FOO', 'Makefile.legacy', 90)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_definition)
def test_handle_definition(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_definition(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


handle_usage = [
    ('legacy',
     'Makefile.legacy',
     8,
     'ifeq ($(BR2_LEGACY),y)',
     True,
     {'add_symbol_usage_in_legacy': [call('BR2_LEGACY', 'Makefile.legacy', 8)]}),
    ('attribution',
     'Makefile',
     9,
     'BR2_FOO = $(BR2_BAR)',
     False,
     {'add_symbol_usage': [call('BR2_BAR', 'Makefile', 9)]}),
    ('host virtual package',
     'package/foo/foo.mk',
     18,
     '$(eval $(host-virtual-package))',
     False,
     {'add_symbol_usage': [
         call('BR2_PACKAGE_PROVIDES_HOST_FOO', 'package/foo/foo.mk', 18),
         call('BR2_PACKAGE_HAS_HOST_FOO', 'package/foo/foo.mk', 18),
         call('BR2_PACKAGE_HOST_FOO', 'package/foo/foo.mk', 18)]}),
    ]


@pytest.mark.parametrize('testname,filename,lineno,line,legacy,expected_calls', handle_usage)
def test_handle_usage(testname, filename, lineno, line, legacy, expected_calls):
    db = Mock()
    m.handle_usage(db, filename, lineno, line, legacy)
    assert_db_calls(db, expected_calls)


populate_db = [
    ('legacy',
     'Makefile.legacy',
     [[8, 'ifeq ($(BR2_LEGACY),y)'],
      [9, 'BR2_LEGACY_FOO := foo'],
      [34, 'ifneq ($(BUILDROOT_CONFIG),$(BR2_CONFIG))']],
     {'add_symbol_usage_in_legacy': [
         call('BR2_LEGACY', 'Makefile.legacy', 8),
         call('BR2_CONFIG', 'Makefile.legacy', 34)],
      'add_symbol_legacy_definition': [call('BR2_LEGACY_FOO', 'Makefile.legacy', 9)]}),
    ('attribution',
     'Makefile',
     [[9, 'BR2_FOO = $(BR2_BAR)']],
     {'add_symbol_definition': [call('BR2_FOO', 'Makefile', 9)],
      'add_symbol_usage': [call('BR2_BAR', 'Makefile', 9)]}),
    ('legacy attribution',
     'Makefile.legacy',
     [[9, 'BR2_FOO = $(BR2_BAR)']],
     {'add_symbol_legacy_definition': [call('BR2_FOO', 'Makefile.legacy', 9)],
      'add_symbol_usage_in_legacy': [call('BR2_BAR', 'Makefile.legacy', 9)]}),
    ('generic',
     'package/foo/foo.mk',
     [[3, 'ifeq ($(BR2_PACKAGE_FOO_BAR):$(BR2_BAR),y:)'],
      [4, 'export BR2_PACKAGE_FOO_BAZ'],
      [5, '$(eval $(generic-package))']],
     {'add_symbol_usage': [
         call('BR2_PACKAGE_FOO_BAR', 'package/foo/foo.mk', 3),
         call('BR2_BAR', 'package/foo/foo.mk', 3),
         call('BR2_PACKAGE_FOO', 'package/foo/foo.mk', 5)],
      'add_symbol_definition': [call('BR2_PACKAGE_FOO_BAZ', 'package/foo/foo.mk', 4)]}),
    ('rootfs',
     'fs/foo/foo.mk',
     [[4, 'ifeq ($(BR2_TARGET_ROOTFS_FOO_LZ4),y)'],
      [5, '$(eval $(rootfs))']],
     {'add_symbol_usage': [
         call('BR2_TARGET_ROOTFS_FOO', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_BZIP2', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_GZIP', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_LZ4', 'fs/foo/foo.mk', 4),
         call('BR2_TARGET_ROOTFS_FOO_LZ4', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_LZMA', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_LZO', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_XZ', 'fs/foo/foo.mk', 5),
         call('BR2_TARGET_ROOTFS_FOO_ZSTD', 'fs/foo/foo.mk', 5)]}),
    ]


@pytest.mark.parametrize('testname,filename,file_content,expected_calls', populate_db)
def test_populate_db(testname, filename, file_content, expected_calls):
    db = Mock()
    m.populate_db(db, filename, file_content)
    assert_db_calls(db, expected_calls)


check_filename = [
    ('arch/arch.mk.riscv',
     'arch/arch.mk.riscv',
     True),
    ('fs/cramfs/cramfs.mk',
     'fs/cramfs/cramfs.mk',
     True),
    ('linux/linux-ext-fbtft.mk',
     'linux/linux-ext-fbtft.mk',
     True),
    ('package/ace/ace.mk',
     'package/ace/ace.mk',
     True),
    ('package/linux-tools/linux-tool-hv.mk.in',
     'package/linux-tools/linux-tool-hv.mk.in',
     True),
    ('package/pkg-generic.mk',
     'package/pkg-generic.mk',
     True),
    ('package/x11r7/xlib_libXt/xlib_libXt.mk',
     'package/x11r7/xlib_libXt/xlib_libXt.mk',
     True),
    ('support/dependencies/check-host-make.mk',
     'support/dependencies/check-host-make.mk',
     True),
    ('toolchain/toolchain-external/toolchain-external-arm-aarch64-be/toolchain-external-arm-aarch64-be.mk',
     'toolchain/toolchain-external/toolchain-external-arm-aarch64-be/toolchain-external-arm-aarch64-be.mk',
     True),
    ('Makefile.legacy',
     'Makefile.legacy',
     True),
    ('boot/common.mk',
     'boot/common.mk',
     True),
    ('fs/common.mk',
     'fs/common.mk',
     True),
    ('Makefile',
     'Makefile',
     True),
    ('package/Makefile.in',
     'package/Makefile.in',
     True),
    ('Config.in',
     'Config.in',
     False),
    ('package/foo/0001-Makefile.patch',
     'package/foo/0001-Makefile.patch',
     False),
    ]


@pytest.mark.parametrize('testname,filename,expected', check_filename)
def test_check_filename(testname, filename, expected):
    symbols = m.check_filename(filename)
    assert symbols == expected
