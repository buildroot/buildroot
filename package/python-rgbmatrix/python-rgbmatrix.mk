################################################################################
#
# python-rgbmatrix
#
################################################################################

# When updating the version, please also update rpi-rgb-led-matrix
PYTHON_RGBMATRIX_VERSION = f55736f7595bc028451658996eedea9742688bbc  # 2024-08-18
PYTHON_RGBMATRIX_SITE = $(call github,hzeller,rpi-rgb-led-matrix,$(PYTHON_RGBMATRIX_VERSION))
PYTHON_RGBMATRIX_LICENSE = GPL-2.0
PYTHON_RGBMATRIX_LICENSE_FILES = COPYING
PYTHON_RGBMATRIX_INSTALL_STAGING = YES
PYTHON_RGBMATRIX_SETUP_TYPE = setuptools
PYTHON_RGBMATRIX_SUBDIR = bindings/python
PYTHON_RGBMATRIX_DEPENDENCIES = host-python-cython rpi-rgb-led-matrix

# Generate bindings with cython
define PYTHON_RGBMATRIX_CYTHON
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/bindings/python/rgbmatrix \
		CYTHON=$(HOST_DIR)/bin/cython all
endef
PYTHON_RGBMATRIX_PRE_BUILD_HOOKS += PYTHON_RGBMATRIX_CYTHON

$(eval $(python-package))
