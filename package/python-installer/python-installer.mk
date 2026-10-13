################################################################################
#
# python-installer
#
################################################################################

PYTHON_INSTALLER_VERSION = 1.1.0
PYTHON_INSTALLER_SOURCE = installer-$(PYTHON_INSTALLER_VERSION).tar.gz
PYTHON_INSTALLER_SITE = https://files.pythonhosted.org/packages/56/d3/2fab33d15004d41ae8e7b5d3e310510f7f34a7e1dd032a3e60d8b38d8fba
PYTHON_INSTALLER_LICENSE = MIT
PYTHON_INSTALLER_LICENSE_FILES = LICENSE
PYTHON_INSTALLER_SETUP_TYPE = flit-bootstrap
HOST_PYTHON_INSTALLER_DEPENDENCIES = host-python-flit-core
HOST_PYTHON_INSTALLER_ENV = PYTHONPATH="$(@D)/src"

$(eval $(host-python-package))
