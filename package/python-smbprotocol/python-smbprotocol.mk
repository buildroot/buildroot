################################################################################
#
# python-smbprotocol
#
################################################################################

PYTHON_SMBPROTOCOL_VERSION = 1.16.0
PYTHON_SMBPROTOCOL_SOURCE = smbprotocol-$(PYTHON_SMBPROTOCOL_VERSION).tar.gz
PYTHON_SMBPROTOCOL_SITE = https://files.pythonhosted.org/packages/c0/5e/1eb2adb1e4739e8a1571f4a641850569ed65d72f72e3d3fd4b121e424795
PYTHON_SMBPROTOCOL_SETUP_TYPE = setuptools
PYTHON_SMBPROTOCOL_LICENSE = MIT
PYTHON_SMBPROTOCOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
