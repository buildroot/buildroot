################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 3.1.1
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/29/bc/c11c9a14bb5b4d18a024ee51da15b793d1c869d151bb4101e324e0d055a8
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))
