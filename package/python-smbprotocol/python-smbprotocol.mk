################################################################################
#
# python-smbprotocol
#
################################################################################

PYTHON_SMBPROTOCOL_VERSION = 1.15.0
PYTHON_SMBPROTOCOL_SOURCE = smbprotocol-$(PYTHON_SMBPROTOCOL_VERSION).tar.gz
PYTHON_SMBPROTOCOL_SITE = https://files.pythonhosted.org/packages/c7/b4/68d75ae0c2f925976c7a58dd9bd26741378c79c6d56d57c72fabcbe595c4
PYTHON_SMBPROTOCOL_SETUP_TYPE = setuptools
PYTHON_SMBPROTOCOL_LICENSE = MIT
PYTHON_SMBPROTOCOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
