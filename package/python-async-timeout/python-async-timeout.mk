################################################################################
#
# python-async-timeout
#
################################################################################

PYTHON_ASYNC_TIMEOUT_VERSION = 5.0.0
PYTHON_ASYNC_TIMEOUT_SOURCE = async_timeout-$(PYTHON_ASYNC_TIMEOUT_VERSION).tar.gz
PYTHON_ASYNC_TIMEOUT_SITE = https://files.pythonhosted.org/packages/61/1f/44d9efc904bbe4d9967433522b691a9c4f1e81c2c64fbe44bad63d5de646
PYTHON_ASYNC_TIMEOUT_LICENSE = Apache-2.0
PYTHON_ASYNC_TIMEOUT_LICENSE_FILES = LICENSE
PYTHON_ASYNC_TIMEOUT_SETUP_TYPE = setuptools

$(eval $(python-package))
