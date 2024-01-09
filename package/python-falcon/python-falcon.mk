################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 3.1.3
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/3b/30/a7bc770025b6a7a36d0508e3d735dca239df7c27b862856e54d661f24632
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))
