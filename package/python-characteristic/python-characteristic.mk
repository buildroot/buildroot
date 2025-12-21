################################################################################
#
# python-characteristic
#
################################################################################

PYTHON_CHARACTERISTIC_VERSION = 14.3.0
PYTHON_CHARACTERISTIC_SOURCE = characteristic-$(PYTHON_CHARACTERISTIC_VERSION).tar.gz
PYTHON_CHARACTERISTIC_SITE = https://files.pythonhosted.org/packages/dc/66/54b7a4758ea44fbc93895c7745060005272560fb2c356f2a6f7448ef9a80
PYTHON_CHARACTERISTIC_LICENSE = MIT
PYTHON_CHARACTERISTIC_LICENSE_FILES = LICENSE
PYTHON_CHARACTERISTIC_SETUP_TYPE = setuptools

$(eval $(python-package))
