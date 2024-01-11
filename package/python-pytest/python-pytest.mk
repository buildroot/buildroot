################################################################################
#
# python-pytest
#
################################################################################

PYTHON_PYTEST_VERSION = 7.4.4
PYTHON_PYTEST_SOURCE = pytest-$(PYTHON_PYTEST_VERSION).tar.gz
PYTHON_PYTEST_SITE = https://files.pythonhosted.org/packages/80/1f/9d8e98e4133ffb16c90f3b405c43e38d3abb715bb5d7a63a5a684f7e46a3
PYTHON_PYTEST_SETUP_TYPE = setuptools
PYTHON_PYTEST_LICENSE = MIT
PYTHON_PYTEST_LICENSE_FILES = LICENSE
PYTHON_PYTEST_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
