################################################################################
#
# python3-cffi
#
################################################################################

# Please keep in sync with package/python-cffi/python-cffi.mk
PYTHON3_CFFI_VERSION = 1.15.0
PYTHON3_CFFI_SOURCE = cffi-$(PYTHON3_CFFI_VERSION).tar.gz
PYTHON3_CFFI_SITE = https://files.pythonhosted.org/packages/00/9e/92de7e1217ccc3d5f352ba21e52398372525765b2e0c4530e6eb2ba9282a
PYTHON3_CFFI_SETUP_TYPE = setuptools
PYTHON3_CFFI_LICENSE = MIT
PYTHON3_CFFI_LICENSE_FILES = LICENSE

# This host package uses pkg-config to find libffi, so we have to
# provide the proper hints for pkg-config to behave properly for host
# packages.
HOST_PYTHON3_CFFI_ENV = \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_LIBDIR="$(HOST_DIR)/lib/pkgconfig:$(HOST_DIR)/share/pkgconfig"
HOST_PYTHON3_CFFI_DEPENDENCIES = host-pkgconf host-python3-pycparser host-libffi

HOST_PYTHON3_CFFI_DL_SUBDIR = python-cffi
HOST_PYTHON3_CFFI_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
