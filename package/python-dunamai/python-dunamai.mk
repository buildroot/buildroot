################################################################################
#
# python-dunamai
#
################################################################################

PYTHON_DUNAMAI_VERSION = 1.26.2
PYTHON_DUNAMAI_SOURCE = dunamai-$(PYTHON_DUNAMAI_VERSION).tar.gz
PYTHON_DUNAMAI_SITE = https://files.pythonhosted.org/packages/12/18/020d3b27a10450ddb11429f637404e8ea67ecf4d9fd999d4f1d553f25506
PYTHON_DUNAMAI_SETUP_TYPE = poetry
PYTHON_DUNAMAI_LICENSE = MIT
PYTHON_DUNAMAI_LICENSE_FILES = LICENSE
HOST_PYTHON_DUNAMAI_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
