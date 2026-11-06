################################################################################
#
# python-pylibftdi
#
################################################################################

PYTHON_PYLIBFTDI_VERSION = 0.25.0
PYTHON_PYLIBFTDI_SOURCE = pylibftdi-$(PYTHON_PYLIBFTDI_VERSION).tar.gz
PYTHON_PYLIBFTDI_SITE = https://files.pythonhosted.org/packages/12/5b/ddac3684466db288c7c2113fb2eaa89f663e088159123084e5b9ce3efcd6
PYTHON_PYLIBFTDI_LICENSE = MIT
PYTHON_PYLIBFTDI_LICENSE_FILES = LICENSE.txt
PYTHON_PYLIBFTDI_SETUP_TYPE = setuptools
PYTHON_PYLIBFTDI_DEPENDENCIES = libftdi

$(eval $(python-package))
