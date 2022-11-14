################################################################################
#
# python-async-timeout
#
################################################################################

PYTHON_ASYNC_TIMEOUT_VERSION = 4.0.2
PYTHON_ASYNC_TIMEOUT_SOURCE = async-timeout-$(PYTHON_ASYNC_TIMEOUT_VERSION).tar.gz
PYTHON_ASYNC_TIMEOUT_SITE = https://files.pythonhosted.org/packages/54/6e/9678f7b2993537452710ffb1750c62d2c26df438aa621ad5fa9d1507a43a
PYTHON_ASYNC_TIMEOUT_LICENSE = Apache-2.0
PYTHON_ASYNC_TIMEOUT_LICENSE_FILES = LICENSE
PYTHON_ASYNC_TIMEOUT_SETUP_TYPE = setuptools

$(eval $(python-package))
