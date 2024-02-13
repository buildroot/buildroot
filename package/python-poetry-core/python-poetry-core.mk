################################################################################
#
# python-poetry-core
#
################################################################################

PYTHON_POETRY_CORE_VERSION = 1.7.0
PYTHON_POETRY_CORE_SOURCE = poetry_core-$(PYTHON_POETRY_CORE_VERSION).tar.gz
PYTHON_POETRY_CORE_SITE = https://files.pythonhosted.org/packages/cb/1c/af7f886e723b2dfbaea9b8a739153f227b386dd856cf956f9fd0ed0a502b
PYTHON_POETRY_CORE_SETUP_TYPE = pep517
PYTHON_POETRY_CORE_LICENSE = MIT
PYTHON_POETRY_CORE_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
