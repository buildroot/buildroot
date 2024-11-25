################################################################################
#
# python-dunamai
#
################################################################################

PYTHON_DUNAMAI_VERSION = 1.22.0
PYTHON_DUNAMAI_SOURCE = dunamai-$(PYTHON_DUNAMAI_VERSION).tar.gz
PYTHON_DUNAMAI_SITE = https://files.pythonhosted.org/packages/a0/fe/aee602f08765de4dd753d2e5d6cbd480857182e345f161f7a19ad1979e4d
PYTHON_DUNAMAI_SETUP_TYPE = poetry
PYTHON_DUNAMAI_LICENSE = MIT
PYTHON_DUNAMAI_LICENSE_FILES = LICENSE
HOST_PYTHON_DUNAMAI_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
