################################################################################
#
# python-smbprotocol
#
################################################################################

PYTHON_SMBPROTOCOL_VERSION = 1.10.1
PYTHON_SMBPROTOCOL_SOURCE = smbprotocol-$(PYTHON_SMBPROTOCOL_VERSION).tar.gz
PYTHON_SMBPROTOCOL_SITE = https://files.pythonhosted.org/packages/13/1a/73ad1883beebe4f6f47879cb9880690944faa00681141920c7a2219f6152
PYTHON_SMBPROTOCOL_SETUP_TYPE = setuptools
PYTHON_SMBPROTOCOL_LICENSE = MIT
PYTHON_SMBPROTOCOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
