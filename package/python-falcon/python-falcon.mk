################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 4.4.0
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/a4/c7/a0584e932cdb42ab6e5dc3baab16352471dda1ba2215311c65d79ea3c0de
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))
