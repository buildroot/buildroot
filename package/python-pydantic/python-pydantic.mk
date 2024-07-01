################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 2.8.0
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/8b/7b/23dc30fba5793d7be3307f33bebb36e08f78f8af9c03fce608833f01bebd
PYTHON_PYDANTIC_SETUP_TYPE = pep517
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CPE_ID_VENDOR = pydantic_project
PYTHON_PYDANTIC_CPE_ID_PRODUCT = pydantic
PYTHON_PYDANTIC_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
