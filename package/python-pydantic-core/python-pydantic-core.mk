################################################################################
#
# python-pydantic-core
#
################################################################################

PYTHON_PYDANTIC_CORE_VERSION = 2.14.6
PYTHON_PYDANTIC_CORE_SOURCE = pydantic_core-$(PYTHON_PYDANTIC_CORE_VERSION).tar.gz
PYTHON_PYDANTIC_CORE_SITE = https://files.pythonhosted.org/packages/b2/7d/8304d8471cfe4288f95a3065ebda56f9790d087edc356ad5bd83c89e2d79
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CORE_DEPENDENCIES = host-python-typing-extensions

$(eval $(python-package))
