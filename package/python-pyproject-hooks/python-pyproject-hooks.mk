################################################################################
#
# python-pyproject-hooks
#
################################################################################

PYTHON_PYPROJECT_HOOKS_VERSION = 1.2.0
PYTHON_PYPROJECT_HOOKS_SOURCE = pyproject_hooks-$(PYTHON_PYPROJECT_HOOKS_VERSION).tar.gz
PYTHON_PYPROJECT_HOOKS_SITE = https://files.pythonhosted.org/packages/e7/82/28175b2414effca1cdac8dc99f76d660e7a4fb0ceefa4b4ab8f5f6742925
PYTHON_PYPROJECT_HOOKS_SETUP_TYPE = flit-bootstrap
PYTHON_PYPROJECT_HOOKS_LICENSE = MIT
PYTHON_PYPROJECT_HOOKS_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
