################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 4.0.2
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/37/4f/d317952294dee1982cd930c8ee2b8b7fbf04140473882801061b3346c713
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))
