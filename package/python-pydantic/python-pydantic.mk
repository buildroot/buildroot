################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 2.14.2
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/9f/d5/b4867fa7c7f04c34997d7d8aad744f64d210bb99d67cf18bf3fb1eea1aed
PYTHON_PYDANTIC_SETUP_TYPE = hatch
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CPE_ID_VENDOR = pydantic_project
PYTHON_PYDANTIC_CPE_ID_PRODUCT = pydantic
PYTHON_PYDANTIC_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
