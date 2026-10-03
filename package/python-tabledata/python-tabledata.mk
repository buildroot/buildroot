################################################################################
#
# python-tabledata
#
################################################################################

PYTHON_TABLEDATA_VERSION = 1.3.5
PYTHON_TABLEDATA_SOURCE = tabledata-$(PYTHON_TABLEDATA_VERSION).tar.gz
PYTHON_TABLEDATA_SITE = https://files.pythonhosted.org/packages/75/65/2f54f0dedd775dde48e300023d20e13ad329a51e33dcadb6d47b4dc95768
PYTHON_TABLEDATA_SETUP_TYPE = setuptools
PYTHON_TABLEDATA_LICENSE = MIT
PYTHON_TABLEDATA_LICENSE_FILES = LICENSE
PYTHON_TABLEDATA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
