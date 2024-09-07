################################################################################
#
# python-pydantic-core
#
################################################################################

PYTHON_PYDANTIC_CORE_VERSION = 2.23.2
PYTHON_PYDANTIC_CORE_SOURCE_PYPI = pydantic_core-$(PYTHON_PYDANTIC_CORE_VERSION).tar.gz
PYTHON_PYDANTIC_CORE_SITE_PYPI = https://files.pythonhosted.org/packages/5f/03/54e4961dfaed4804fea0ad73e94d337f4ef88a635e73990d6e150b469594
PYTHON_PYDANTIC_CORE_SITE = $(PYTHON_PYDANTIC_CORE_SITE_PYPI)/$(PYTHON_PYDANTIC_CORE_SOURCE_PYPI)?buildroot-path=filename
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CORE_DEPENDENCIES = host-python-typing-extensions

$(eval $(python-package))
