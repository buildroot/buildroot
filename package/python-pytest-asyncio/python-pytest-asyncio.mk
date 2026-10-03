################################################################################
#
# python-pytest-asyncio
#
################################################################################

PYTHON_PYTEST_ASYNCIO_VERSION = 1.4.0
PYTHON_PYTEST_ASYNCIO_SOURCE = pytest_asyncio-$(PYTHON_PYTEST_ASYNCIO_VERSION).tar.gz
PYTHON_PYTEST_ASYNCIO_SITE = https://files.pythonhosted.org/packages/43/7c/d36d04db312ecf4298932ef77e6e4a9e8ad017906e24e34f0b0c361a2473
PYTHON_PYTEST_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_PYTEST_ASYNCIO_LICENSE = Apache-2.0
PYTHON_PYTEST_ASYNCIO_LICENSE_FILES = LICENSE
PYTHON_PYTEST_ASYNCIO_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
