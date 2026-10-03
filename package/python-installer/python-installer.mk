################################################################################
#
# python-installer
#
################################################################################

PYTHON_INSTALLER_VERSION = 1.0.1
PYTHON_INSTALLER_SOURCE = installer-$(PYTHON_INSTALLER_VERSION).tar.gz
PYTHON_INSTALLER_SITE = https://files.pythonhosted.org/packages/06/fe/b9f481cf0cc867958a21338baa900357b7b7d86cac9b025948049d77923c
PYTHON_INSTALLER_LICENSE = MIT
PYTHON_INSTALLER_LICENSE_FILES = LICENSE
PYTHON_INSTALLER_SETUP_TYPE = flit-bootstrap
HOST_PYTHON_INSTALLER_DEPENDENCIES = host-python-flit-core
HOST_PYTHON_INSTALLER_ENV = PYTHONPATH="$(@D)/src"

$(eval $(host-python-package))
