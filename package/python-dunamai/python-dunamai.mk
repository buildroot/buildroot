################################################################################
#
# python-dunamai
#
################################################################################

PYTHON_DUNAMAI_VERSION = 1.23.0
PYTHON_DUNAMAI_SOURCE = dunamai-$(PYTHON_DUNAMAI_VERSION).tar.gz
PYTHON_DUNAMAI_SITE = https://files.pythonhosted.org/packages/06/4e/a5c8c337a1d9ac0384298ade02d322741fb5998041a5ea74d1cd2a4a1d47
PYTHON_DUNAMAI_SETUP_TYPE = poetry
PYTHON_DUNAMAI_LICENSE = MIT
PYTHON_DUNAMAI_LICENSE_FILES = LICENSE
HOST_PYTHON_DUNAMAI_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
