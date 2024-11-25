################################################################################
#
# python-async-timeout
#
################################################################################

PYTHON_ASYNC_TIMEOUT_VERSION = 5.0.1
PYTHON_ASYNC_TIMEOUT_SOURCE = async_timeout-$(PYTHON_ASYNC_TIMEOUT_VERSION).tar.gz
PYTHON_ASYNC_TIMEOUT_SITE = https://files.pythonhosted.org/packages/a5/ae/136395dfbfe00dfc94da3f3e136d0b13f394cba8f4841120e34226265780
PYTHON_ASYNC_TIMEOUT_LICENSE = Apache-2.0
PYTHON_ASYNC_TIMEOUT_LICENSE_FILES = LICENSE
PYTHON_ASYNC_TIMEOUT_SETUP_TYPE = setuptools

$(eval $(python-package))
