################################################################################
#
# python3-cffi
#
################################################################################

# Please keep in sync with package/python-cffi/python-cffi.mk
PYTHON3_CFFI_VERSION = 1.14.2
PYTHON3_CFFI_SOURCE = cffi-$(PYTHON3_CFFI_VERSION).tar.gz
PYTHON3_CFFI_SITE = https://files.pythonhosted.org/packages/f7/09/88bbe20b76ca76be052c366fe77aa5e3cd6e5f932766e5597fecdd95b2a8
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
