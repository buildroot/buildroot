################################################################################
#
# python-setuptools
#
################################################################################

PYTHON_SETUPTOOLS_VERSION = 62.6.0
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VERSION).tar.gz
PYTHON_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/dc/73/88920663229023b724a854d1ab7e3e50a1a28b63eeec399a604ba30f9242
PYTHON_SETUPTOOLS_LICENSE = MIT
PYTHON_SETUPTOOLS_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_CPE_ID_VENDOR = python
PYTHON_SETUPTOOLS_CPE_ID_PRODUCT = setuptools
PYTHON_SETUPTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
