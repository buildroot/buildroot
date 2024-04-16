################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 2.5.3
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/aa/3f/56142232152145ecbee663d70a19a45d078180633321efb3847d2562b490
PYTHON_PYDANTIC_SETUP_TYPE = pep517
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CPE_ID_VENDOR = pydantic_project
PYTHON_PYDANTIC_CPE_ID_PRODUCT = pydantic
PYTHON_PYDANTIC_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
