################################################################################
#
# python-smbprotocol
#
################################################################################

PYTHON_SMBPROTOCOL_VERSION = 1.14.0
PYTHON_SMBPROTOCOL_SOURCE = smbprotocol-$(PYTHON_SMBPROTOCOL_VERSION).tar.gz
PYTHON_SMBPROTOCOL_SITE = https://files.pythonhosted.org/packages/41/0d/d178f651591de45607d6dfc5637e7dcd8c5190b137275303cda005d9a13a
PYTHON_SMBPROTOCOL_SETUP_TYPE = setuptools
PYTHON_SMBPROTOCOL_LICENSE = MIT
PYTHON_SMBPROTOCOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
