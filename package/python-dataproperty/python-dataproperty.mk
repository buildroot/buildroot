################################################################################
#
# python-dataproperty
#
################################################################################

PYTHON_DATAPROPERTY_VERSION = 1.1.1
PYTHON_DATAPROPERTY_SOURCE = dataproperty-$(PYTHON_DATAPROPERTY_VERSION).tar.gz
PYTHON_DATAPROPERTY_SITE = https://files.pythonhosted.org/packages/f1/6f/a801320bb388d965be9c370ec753cc33120e6cbe0069fa05644f05821975
PYTHON_DATAPROPERTY_SETUP_TYPE = setuptools
PYTHON_DATAPROPERTY_LICENSE = MIT
PYTHON_DATAPROPERTY_LICENSE_FILES = LICENSE
PYTHON_DATAPROPERTY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
