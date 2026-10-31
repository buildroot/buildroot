################################################################################
#
# python-pytest-asyncio
#
################################################################################

PYTHON_PYTEST_ASYNCIO_VERSION = 1.4.1
PYTHON_PYTEST_ASYNCIO_SOURCE = pytest_asyncio-$(PYTHON_PYTEST_ASYNCIO_VERSION).tar.gz
PYTHON_PYTEST_ASYNCIO_SITE = https://files.pythonhosted.org/packages/f8/9a/887535e477847f5159377ab35303923644840b13c0ca03c0a467f84d4680
PYTHON_PYTEST_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_PYTEST_ASYNCIO_LICENSE = Apache-2.0
PYTHON_PYTEST_ASYNCIO_LICENSE_FILES = LICENSE
PYTHON_PYTEST_ASYNCIO_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
