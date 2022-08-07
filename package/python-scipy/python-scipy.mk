################################################################################
#
# python-scipy
#
################################################################################

PYTHON_SCIPY_VERSION = 1.8.1
PYTHON_SCIPY_SOURCE = scipy-$(PYTHON_SCIPY_VERSION).tar.xz
PYTHON_SCIPY_SITE = https://github.com/scipy/scipy/releases/download/v$(PYTHON_SCIPY_VERSION)
PYTHON_SCIPY_LICENSE = \
	BSD-3-Clause, \
	BSD-2-Clause, \
	BSD, \
	BSD-Style, \
	MIT, \
	Qhull
PYTHON_SCIPY_LICENSE_FILES = \
	LICENSE.txt \
	scipy/linalg/src/lapack_deprecations/LICENSE \
	scipy/ndimage/LICENSE.txt \
	scipy/optimize/tnc/LICENSE \
	scipy/sparse/linalg/_dsolve/SuperLU/License.txt \
	scipy/sparse/linalg/_eigen/arpack/ARPACK/COPYING \
	scipy/spatial/qhull_src/COPYING.txt
PYTHON_SCIPY_CPE_ID_VENDOR = scipy
PYTHON_SCIPY_CPE_ID_PRODUCT = scipy
PYTHON_SCIPY_DEPENDENCIES += \
	host-python-numpy \
	host-python-pythran \
	zlib \
	lapack \
	python-numpy \
	python-pybind
PYTHON_SCIPY_INSTALL_STAGING = YES

PYTHON_SCIPY_SETUP_TYPE = setuptools
PYTHON_SCIPY_BUILD_OPTS = config_fc --fcompiler=gnu95

PYTHON_SCIPY_LDFLAGS = $(TARGET_LDFLAGS) -shared \
	-L$(PYTHON3_PATH)/site-packages/numpy/core/lib
# -lnpyrandom localization
PYTHON_SCIPY_LDFLAGS += \
	-L$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/numpy/random/lib

PYTHON_SCIPY_ENV = \
	F90=$(TARGET_FC) \
	LDFLAGS="$(PYTHON_SCIPY_LDFLAGS)"

# Provide system configuration options to numpy distutils extensions, telling
# to find all include files and libraries in staging directory.
define PYTHON_SCIPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/usr/include" >> $(@D)/site.cfg
endef

$(eval $(python-package))
