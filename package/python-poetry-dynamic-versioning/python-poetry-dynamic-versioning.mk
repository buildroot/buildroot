################################################################################
#
# python-poetry-dynamic-versioning
#
################################################################################

PYTHON_POETRY_DYNAMIC_VERSIONING_VERSION = 1.4.1
PYTHON_POETRY_DYNAMIC_VERSIONING_SOURCE = poetry_dynamic_versioning-$(PYTHON_POETRY_DYNAMIC_VERSIONING_VERSION).tar.gz
PYTHON_POETRY_DYNAMIC_VERSIONING_SITE = https://files.pythonhosted.org/packages/dd/70/1138211a6e5051d28596922ed39acf20b42819db5ae1f93e465b9a903c28
PYTHON_POETRY_DYNAMIC_VERSIONING_SETUP_TYPE = poetry
PYTHON_POETRY_DYNAMIC_VERSIONING_LICENSE = MIT
PYTHON_POETRY_DYNAMIC_VERSIONING_LICENSE_FILES = LICENSE
HOST_PYTHON_POETRY_DYNAMIC_VERSIONING_DEPENDENCIES = \
	host-python-dunamai \
	host-python-jinja2 \
	host-python-tomlkit

$(eval $(host-python-package))
