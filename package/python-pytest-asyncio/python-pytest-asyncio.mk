################################################################################
#
# python-pytest-asyncio
#
################################################################################

PYTHON_PYTEST_ASYNCIO_VERSION = 0.21.1
PYTHON_PYTEST_ASYNCIO_SOURCE = pytest-asyncio-$(PYTHON_PYTEST_ASYNCIO_VERSION).tar.gz
PYTHON_PYTEST_ASYNCIO_SITE = https://files.pythonhosted.org/packages/5a/85/d39ef5f69d5597a206f213ce387bcdfa47922423875829f7a98a87d33281
PYTHON_PYTEST_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_PYTEST_ASYNCIO_LICENSE = Apache-2.0
PYTHON_PYTEST_ASYNCIO_LICENSE_FILES = LICENSE

$(eval $(python-package))
