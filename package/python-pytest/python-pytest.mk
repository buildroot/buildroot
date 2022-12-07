################################################################################
#
# python-pytest
#
################################################################################

PYTHON_PYTEST_VERSION = 7.2.0
PYTHON_PYTEST_SOURCE = pytest-$(PYTHON_PYTEST_VERSION).tar.gz
PYTHON_PYTEST_SITE = https://files.pythonhosted.org/packages/0b/21/055f39bf8861580b43f845f9e8270c7786fe629b2f8562ff09007132e2e7
PYTHON_PYTEST_SETUP_TYPE = setuptools
PYTHON_PYTEST_LICENSE = MIT
PYTHON_PYTEST_LICENSE_FILES = LICENSE
PYTHON_PYTEST_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
