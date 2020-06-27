################################################################################
#
# python-numpy
#
################################################################################

PYTHON_NUMPY_VERSION = 1.21.2
PYTHON_NUMPY_SOURCE = numpy-$(PYTHON_NUMPY_VERSION).tar.gz
PYTHON_NUMPY_SITE = https://github.com/numpy/numpy/releases/download/v$(PYTHON_NUMPY_VERSION)
PYTHON_NUMPY_LICENSE = BSD-3-Clause, MIT, Zlib
PYTHON_NUMPY_LICENSE_FILES = \
	LICENSE.txt \
	numpy/core/src/multiarray/dragon4.c \
	numpy/core/include/numpy/libdivide/LICENSE.txt \
	numpy/linalg/lapack_lite/LICENSE.txt \
	tools/npy_tempita/license.txt

PYTHON_NUMPY_SETUP_TYPE = setuptools
PYTHON_NUMPY_DEPENDENCIES = host-python-cython
HOST_PYTHON_NUMPY_DEPENDENCIES = host-python-cython

ifeq ($(BR2_PACKAGE_LAPACK),y)
PYTHON_NUMPY_DEPENDENCIES += lapack
else
PYTHON_NUMPY_ENV += BLAS=None LAPACK=None
endif

ifeq ($(BR2_TOOLCHAIN_HAS_FORTRAN),y)
PYTHON_NUMPY_BUILD_OPTS = --fcompiler=gnu95
PYTHON_NUMPY_ENV += F90=$(TARGET_FC)
else
PYTHON_NUMPY_BUILD_OPTS = --fcompiler=None
endif

define PYTHON_NUMPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/usr/include" >> $(@D)/site.cfg
endef

# Fixup the npymath.ini prefix path with actual target staging area where
# numpy core was built. Without this, target builds using numpy distutils
# extensions like python-scipy, python-numba cannot find -lnpymath since
# it uses host libraries (like libnpymath.a).
# So, the numpy distutils extension packages would explicitly link this
# config path for their package environment.
define PYTHON_NUMPY_FIXUP_NPY_PKG_CONFIG_FILES
	$(SED) '/^pkgdir=/d;/^prefix=/i pkgdir=$(PYTHON3_PATH)/site-packages/numpy/core' \
		$(PYTHON3_PATH)/site-packages/numpy/core/lib/npy-pkg-config/npymath.ini
endef
PYTHON_NUMPY_POST_INSTALL_STAGING_HOOKS += PYTHON_NUMPY_FIXUP_NPY_PKG_CONFIG_FILES

# Some package may include few headers from NumPy, so let's install it
# in the staging area.
PYTHON_NUMPY_INSTALL_STAGING = YES

$(eval $(python-package))
$(eval $(host-python-package))
