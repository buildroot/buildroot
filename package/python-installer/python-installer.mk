################################################################################
#
# python-installer
#
################################################################################

PYTHON_INSTALLER_VERSION = 0.5.1
PYTHON_INSTALLER_SOURCE = installer-$(PYTHON_INSTALLER_VERSION).tar.gz
PYTHON_INSTALLER_SITE = https://files.pythonhosted.org/packages/74/b7/9187323cd732840f1cddd6a9f05961406636b50c799eef37c920b63110c0
PYTHON_INSTALLER_LICENSE = MIT
PYTHON_INSTALLER_LICENSE_FILES = LICENSE
PYTHON_INSTALLER_SETUP_TYPE = flit-bootstrap
HOST_PYTHON_INSTALLER_DEPENDENCIES = host-python-flit-core
HOST_PYTHON_INSTALLER_ENV = PYTHONPATH="$(@D)/src"

$(eval $(host-python-package))
