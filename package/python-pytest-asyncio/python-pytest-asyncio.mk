################################################################################
#
# python-pytest-asyncio
#
################################################################################

PYTHON_PYTEST_ASYNCIO_VERSION = 1.4.1.post1
PYTHON_PYTEST_ASYNCIO_SOURCE = pytest_asyncio-$(PYTHON_PYTEST_ASYNCIO_VERSION).tar.gz
PYTHON_PYTEST_ASYNCIO_SITE = https://files.pythonhosted.org/packages/73/7f/c60a4338420b33453d4f814ac0c930abd399f162b9bdd21af4b9e363037f
PYTHON_PYTEST_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_PYTEST_ASYNCIO_LICENSE = Apache-2.0
PYTHON_PYTEST_ASYNCIO_LICENSE_FILES = LICENSE
PYTHON_PYTEST_ASYNCIO_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
