################################################################################
#
# python-numpy
#
################################################################################

PYTHON_NUMPY_VERSION = 1.25.0
PYTHON_NUMPY_SOURCE = numpy-$(PYTHON_NUMPY_VERSION).tar.gz
PYTHON_NUMPY_SITE = https://github.com/numpy/numpy/releases/download/v$(PYTHON_NUMPY_VERSION)
PYTHON_NUMPY_LICENSE = BSD-3-Clause, MIT, Zlib
PYTHON_NUMPY_LICENSE_FILES = \
	LICENSE.txt \
	numpy/core/src/multiarray/dragon4.c \
	numpy/core/include/numpy/libdivide/LICENSE.txt \
	numpy/linalg/lapack_lite/LICENSE.txt \
	tools/npy_tempita/license.txt
PYTHON_NUMPY_CPE_ID_VENDOR = numpy
PYTHON_NUMPY_CPE_ID_PRODUCT = numpy

PYTHON_NUMPY_DEPENDENCIES = host-python-cython python3
HOST_PYTHON_NUMPY_DEPENDENCIES = host-python-cython

PYTHON_NUMPY_CONF_ENV += \
	_PYTHON_SYSCONFIGDATA_NAME=$(PKG_PYTHON_SYSCONFIGDATA_NAME) \
	PYTHONPATH=$(PYTHON3_PATH)

ifeq ($(BR2_PACKAGE_LAPACK),y)
PYTHON_NUMPY_DEPENDENCIES += lapack
PYTHON_NUMPY_CONF_OPTS += -Dlapack=lapack
else
PYTHON_NUMPY_CONF_OPTS += -Dlapack=""
endif

ifeq ($(BR2_PACKAGE_OPENBLAS),y)
PYTHON_NUMPY_DEPENDENCIES += openblas
PYTHON_NUMPY_CONF_OPTS += -Dblas=openblas
else
PYTHON_NUMPY_CONF_OPTS += -Dblas=""
endif

# Rather than add a host-blas or host-lapack dependencies, just use unoptimized,
# in-tree code.
HOST_PYTHON_NUMPY_CONF_OPTS = -Dblas="" -Dlapack=""

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

$(eval $(meson-package))
$(eval $(host-meson-package))
