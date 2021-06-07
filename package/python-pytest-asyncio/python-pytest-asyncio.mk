################################################################################
#
# python-pytest-asyncio
#
################################################################################

PYTHON_PYTEST_ASYNCIO_VERSION = 0.15.1
PYTHON_PYTEST_ASYNCIO_SOURCE = pytest-asyncio-$(PYTHON_PYTEST_ASYNCIO_VERSION).tar.gz
PYTHON_PYTEST_ASYNCIO_SITE = https://files.pythonhosted.org/packages/de/c1/b2b0119e30f61f7ec8b44f129f6fde46a1a7329de17110f124639aa8896b
PYTHON_PYTEST_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_PYTEST_ASYNCIO_LICENSE = Apache-2.0
PYTHON_PYTEST_ASYNCIO_LICENSE_FILES = LICENSE

$(eval $(python-package))
