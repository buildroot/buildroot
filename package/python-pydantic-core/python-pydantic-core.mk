################################################################################
#
# python-pydantic-core
#
################################################################################

PYTHON_PYDANTIC_CORE_VERSION = 2.29.0
PYTHON_PYDANTIC_CORE_SOURCE_PYPI = pydantic_core-$(PYTHON_PYDANTIC_CORE_VERSION).tar.gz
PYTHON_PYDANTIC_CORE_SITE_PYPI = https://files.pythonhosted.org/packages/79/f6/904edea98c98c09b8d618d619749af19a50ea5a71b9199ee2131a5a03dfb
PYTHON_PYDANTIC_CORE_SITE = $(PYTHON_PYDANTIC_CORE_SITE_PYPI)/$(PYTHON_PYDANTIC_CORE_SOURCE_PYPI)?buildroot-path=filename
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CORE_DEPENDENCIES = host-python-typing-extensions

$(eval $(python-package))
