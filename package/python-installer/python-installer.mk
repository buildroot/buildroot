################################################################################
#
# python-installer
#
################################################################################

PYTHON_INSTALLER_VERSION = 0.6.0
PYTHON_INSTALLER_SOURCE = installer-$(PYTHON_INSTALLER_VERSION).tar.gz
PYTHON_INSTALLER_SITE = https://files.pythonhosted.org/packages/c9/ab/a9141dc175ec7b620fffe7e0295251a7b6a0ffb4325d64aeb128dff8c698
PYTHON_INSTALLER_LICENSE = MIT
PYTHON_INSTALLER_LICENSE_FILES = LICENSE
PYTHON_INSTALLER_SETUP_TYPE = flit-bootstrap
HOST_PYTHON_INSTALLER_DEPENDENCIES = host-python-flit-core
HOST_PYTHON_INSTALLER_ENV = PYTHONPATH="$(@D)/src"

$(eval $(host-python-package))
