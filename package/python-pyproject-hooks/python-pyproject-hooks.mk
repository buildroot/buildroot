################################################################################
#
# python-pyproject-hooks
#
################################################################################

PYTHON_PYPROJECT_HOOKS_VERSION = 1.3.3
PYTHON_PYPROJECT_HOOKS_SOURCE = pyproject_hooks-$(PYTHON_PYPROJECT_HOOKS_VERSION).tar.gz
PYTHON_PYPROJECT_HOOKS_SITE = https://files.pythonhosted.org/packages/6d/5d/f2ddeef4a855a102aaae5e97826a0260007522ab504421b75addfdb1517c
PYTHON_PYPROJECT_HOOKS_SETUP_TYPE = flit-bootstrap
PYTHON_PYPROJECT_HOOKS_LICENSE = MIT
PYTHON_PYPROJECT_HOOKS_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
