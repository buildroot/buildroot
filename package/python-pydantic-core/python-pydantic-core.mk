################################################################################
#
# python-pydantic-core
#
################################################################################

PYTHON_PYDANTIC_CORE_VERSION = v2.19.0
PYTHON_PYDANTIC_CORE_SITE = https://github.com/pydantic/pydantic-core
PYTHON_PYDANTIC_CORE_SITE_METHOD = git
PYTHON_PYDANTIC_CORE_SETUP_TYPE = maturin
PYTHON_PYDANTIC_CORE_LICENSE = MIT
PYTHON_PYDANTIC_CORE_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_CORE_DEPENDENCIES = host-python-typing-extensions

$(eval $(python-package))
