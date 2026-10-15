################################################################################
#
# python-dunamai
#
################################################################################

PYTHON_DUNAMAI_VERSION = 1.26.3
PYTHON_DUNAMAI_SOURCE = dunamai-$(PYTHON_DUNAMAI_VERSION).tar.gz
PYTHON_DUNAMAI_SITE = https://files.pythonhosted.org/packages/c5/62/edf5352d8ce1371129ccfe971e6de3a1ce4dc7f9bdc80390fb79856b78d4
PYTHON_DUNAMAI_SETUP_TYPE = poetry
PYTHON_DUNAMAI_LICENSE = MIT
PYTHON_DUNAMAI_LICENSE_FILES = LICENSE
HOST_PYTHON_DUNAMAI_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
