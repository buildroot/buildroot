################################################################################
#
# python-pytest
#
################################################################################

PYTHON_PYTEST_VERSION = 8.3.4
PYTHON_PYTEST_SOURCE = pytest-$(PYTHON_PYTEST_VERSION).tar.gz
PYTHON_PYTEST_SITE = https://files.pythonhosted.org/packages/05/35/30e0d83068951d90a01852cb1cef56e5d8a09d20c7f511634cc2f7e0372a
PYTHON_PYTEST_SETUP_TYPE = setuptools
PYTHON_PYTEST_LICENSE = MIT
PYTHON_PYTEST_LICENSE_FILES = LICENSE
PYTHON_PYTEST_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
