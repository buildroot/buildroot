################################################################################
#
# python-pydantic-core
#
################################################################################

PYTHON_PYDANTIC_CORE_VERSION = 2.25.0
PYTHON_PYDANTIC_CORE_SOURCE_PYPI = pydantic_core-$(PYTHON_PYDANTIC_CORE_VERSION).tar.gz
PYTHON_PYDANTIC_CORE_SITE_PYPI = https://files.pythonhosted.org/packages/b5/fc/4e4d9ac36c99c2bbb5a87885abc508f7d274706a571e3be253dc570943eb
PYTHON_PYDANTIC_CORE_SITE = $(PYTHON_PYDANTIC_CORE_SITE_PYPI)/$(PYTHON_PYDANTIC_CORE_SOURCE_PYPI)?buildroot-path=filename
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CORE_DEPENDENCIES = host-python-typing-extensions

$(eval $(python-package))
