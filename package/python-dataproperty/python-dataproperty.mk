################################################################################
#
# python-dataproperty
#
################################################################################

PYTHON_DATAPROPERTY_VERSION = 0.55.0
PYTHON_DATAPROPERTY_SOURCE = DataProperty-$(PYTHON_DATAPROPERTY_VERSION).tar.gz
PYTHON_DATAPROPERTY_SITE = https://files.pythonhosted.org/packages/85/6e/627eba99858c486c5b82468e4aaf60808c2e35d1bb768ee5da712b6fe9be
PYTHON_DATAPROPERTY_SETUP_TYPE = setuptools
PYTHON_DATAPROPERTY_LICENSE = MIT
PYTHON_DATAPROPERTY_LICENSE_FILES = LICENSE

$(eval $(python-package))
