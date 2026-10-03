################################################################################
#
# python-smbprotocol
#
################################################################################

PYTHON_SMBPROTOCOL_VERSION = 1.17.0
PYTHON_SMBPROTOCOL_SOURCE = smbprotocol-$(PYTHON_SMBPROTOCOL_VERSION).tar.gz
PYTHON_SMBPROTOCOL_SITE = https://files.pythonhosted.org/packages/0e/ff/1a86a76423210bc9558e6ea978c576b13da448644401f16ee2260d4d3316
PYTHON_SMBPROTOCOL_SETUP_TYPE = setuptools
PYTHON_SMBPROTOCOL_LICENSE = MIT
PYTHON_SMBPROTOCOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
