################################################################################
#
# python-pydantic-core
#
################################################################################

# python-pydantic pins an exact version of pydantic-core in pyproject.toml,
# make sure to sync pydantic-core to this version when updating pydantic
PYTHON_PYDANTIC_CORE_VERSION = 2.50.2
PYTHON_PYDANTIC_CORE_SOURCE_PYPI = pydantic_core-$(PYTHON_PYDANTIC_CORE_VERSION).tar.gz
PYTHON_PYDANTIC_CORE_SITE = $(PYTHON_PYDANTIC_CORE_SITE_PYPI)/$(PYTHON_PYDANTIC_CORE_SOURCE_PYPI)?buildroot-path=filename
PYTHON_PYDANTIC_CORE_SITE_PYPI = https://files.pythonhosted.org/packages/af/8e/23ec1021834e35041fbb2f10946141e6acdfd39379c45cc4d65a4e8a1d98
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
