################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 2.5.2
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/b7/41/3c8108f79fb7da2d2b17f35744232af4ffcd9e764ebe1e3fd4b26669b325
PYTHON_PYDANTIC_SETUP_TYPE = pep517
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
