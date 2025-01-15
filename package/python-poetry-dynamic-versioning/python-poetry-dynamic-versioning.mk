################################################################################
#
# python-poetry-dynamic-versioning
#
################################################################################

PYTHON_POETRY_DYNAMIC_VERSIONING_VERSION = 1.6.0
PYTHON_POETRY_DYNAMIC_VERSIONING_SOURCE = poetry_dynamic_versioning-$(PYTHON_POETRY_DYNAMIC_VERSIONING_VERSION).tar.gz
PYTHON_POETRY_DYNAMIC_VERSIONING_SITE = https://files.pythonhosted.org/packages/d3/f9/97b14cae52513ee028f1e81aad8a44e3a8f5a5d47570b48219431e131989
PYTHON_POETRY_DYNAMIC_VERSIONING_SETUP_TYPE = poetry
PYTHON_POETRY_DYNAMIC_VERSIONING_LICENSE = MIT
PYTHON_POETRY_DYNAMIC_VERSIONING_LICENSE_FILES = LICENSE
HOST_PYTHON_POETRY_DYNAMIC_VERSIONING_DEPENDENCIES = \
	host-python-dunamai \
	host-python-jinja2 \
	host-python-tomlkit

$(eval $(host-python-package))
