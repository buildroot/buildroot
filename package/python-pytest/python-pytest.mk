################################################################################
#
# python-pytest
#
################################################################################

PYTHON_PYTEST_VERSION = 9.2.0
PYTHON_PYTEST_SOURCE = pytest-$(PYTHON_PYTEST_VERSION).tar.gz
PYTHON_PYTEST_SITE = https://files.pythonhosted.org/packages/79/42/bb4641652e58dedeac2ec51abc1f8cae4fee4ec63899a0999016229a0f2a
PYTHON_PYTEST_SETUP_TYPE = setuptools
PYTHON_PYTEST_LICENSE = MIT
PYTHON_PYTEST_LICENSE_FILES = LICENSE
PYTHON_PYTEST_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
