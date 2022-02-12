################################################################################
#
# python-setuptools
#
################################################################################

PYTHON_SETUPTOOLS_VERSION = 60.8.2
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VERSION).tar.gz
PYTHON_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/ae/0b/e458b0d07dced3d7fa2d21d828e708f374ef82040f2012c05d35f47f9af3
PYTHON_SETUPTOOLS_LICENSE = MIT
PYTHON_SETUPTOOLS_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_CPE_ID_VENDOR = python
PYTHON_SETUPTOOLS_CPE_ID_PRODUCT = setuptools
PYTHON_SETUPTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
