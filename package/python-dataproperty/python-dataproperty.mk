################################################################################
#
# python-dataproperty
#
################################################################################

PYTHON_DATAPROPERTY_VERSION = 1.1.0
PYTHON_DATAPROPERTY_SOURCE = dataproperty-$(PYTHON_DATAPROPERTY_VERSION).tar.gz
PYTHON_DATAPROPERTY_SITE = https://files.pythonhosted.org/packages/0b/81/8c8b64ae873cb9014815214c07b63b12e3b18835780fb342223cfe3fe7d8
PYTHON_DATAPROPERTY_SETUP_TYPE = setuptools
PYTHON_DATAPROPERTY_LICENSE = MIT
PYTHON_DATAPROPERTY_LICENSE_FILES = LICENSE
PYTHON_DATAPROPERTY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
