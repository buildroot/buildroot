################################################################################
#
# python-pydantic-core
#
################################################################################

# python-pydantic pins an exact version of pydantic-core in pyproject.toml,
# make sure to sync pydantic-core to this version when updating pydantic
PYTHON_PYDANTIC_CORE_VERSION = 2.41.5
PYTHON_PYDANTIC_CORE_SOURCE_PYPI = pydantic_core-$(PYTHON_PYDANTIC_CORE_VERSION).tar.gz
PYTHON_PYDANTIC_CORE_SITE = $(PYTHON_PYDANTIC_CORE_SITE_PYPI)/$(PYTHON_PYDANTIC_CORE_SOURCE_PYPI)?buildroot-path=filename
PYTHON_PYDANTIC_CORE_SITE_PYPI = https://files.pythonhosted.org/packages/71/70/23b021c950c2addd24ec408e9ab05d59b035b39d97cdc1130e1bce647bb6
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
