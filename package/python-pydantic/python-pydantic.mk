################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 2.12.4
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/96/ad/a17bc283d7d81837c061c49e3eaa27a45991759a1b7eae1031921c6bd924
PYTHON_PYDANTIC_SETUP_TYPE = hatch
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CPE_ID_VENDOR = pydantic_project
PYTHON_PYDANTIC_CPE_ID_PRODUCT = pydantic
PYTHON_PYDANTIC_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
