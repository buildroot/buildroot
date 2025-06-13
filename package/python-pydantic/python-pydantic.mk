################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 2.11.6
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/ef/8f/9af0f46acc943b8c4592d06523f26a150acf6e6e37e8bd5f0ace925e996d
PYTHON_PYDANTIC_SETUP_TYPE = hatch
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CPE_ID_VENDOR = pydantic_project
PYTHON_PYDANTIC_CPE_ID_PRODUCT = pydantic
PYTHON_PYDANTIC_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
