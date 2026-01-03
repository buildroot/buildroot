################################################################################
#
# python-memray
#
################################################################################

PYTHON_MEMRAY_VERSION = 1.19.1
PYTHON_MEMRAY_SOURCE = memray-$(PYTHON_MEMRAY_VERSION).tar.gz
PYTHON_MEMRAY_SITE = https://files.pythonhosted.org/packages/36/18/5df5995a7b142e12ab194f4b2fd1473efd51f4f622dfe47f3c013c3c11f7
PYTHON_MEMRAY_SETUP_TYPE = setuptools
PYTHON_MEMRAY_LICENSE = Apache-2.0
PYTHON_MEMRAY_LICENSE_FILES = LICENSE src/vendor/libbacktrace/LICENSE
PYTHON_MEMRAY_DEPENDENCIES = host-python-cython host-python-pkgconfig lz4 elfutils libunwind

# Define cross-compile target for bundled & patched libbacktrace.
PYTHON_MEMRAY_ENV = MEMRAY_LIBBACKTRACE_TARGET=$(GNU_TARGET_NAME)

# Sources must be compiled with -fPIC, otherwise linking with -flto
# (which memray sets by default) fails.
PYTHON_MEMRAY_ENV += CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC"

$(eval $(python-package))
