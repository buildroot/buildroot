################################################################################
#
# python-installer
#
################################################################################

PYTHON_INSTALLER_VERSION = 0.4.0
PYTHON_INSTALLER_SOURCE = installer-$(PYTHON_INSTALLER_VERSION).tar.gz
PYTHON_INSTALLER_SITE = https://files.pythonhosted.org/packages/71/9a/8d7c724b0d51336453e75f76b32de86b336ef26755c64119204f1f5b4388
PYTHON_INSTALLER_LICENSE = MIT
PYTHON_INSTALLER_LICENSE_FILES = LICENSE
PYTHON_INSTALLER_SETUP_TYPE = distutils

$(eval $(host-python-package))
