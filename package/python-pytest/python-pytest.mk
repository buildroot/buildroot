################################################################################
#
# python-pytest
#
################################################################################

PYTHON_PYTEST_VERSION = 9.0.2
PYTHON_PYTEST_SOURCE = pytest-$(PYTHON_PYTEST_VERSION).tar.gz
PYTHON_PYTEST_SITE = https://files.pythonhosted.org/packages/d1/db/7ef3487e0fb0049ddb5ce41d3a49c235bf9ad299b6a25d5780a89f19230f
PYTHON_PYTEST_SETUP_TYPE = setuptools
PYTHON_PYTEST_LICENSE = MIT
PYTHON_PYTEST_LICENSE_FILES = LICENSE
PYTHON_PYTEST_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
