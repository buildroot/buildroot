################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 4.0.1
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/29/11/66692243aff20eec2269cbc553af1d30c029a6caebd3bd8bf301ba8b2aad
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))
