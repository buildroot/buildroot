################################################################################
#
# python-async-timeout
#
################################################################################

PYTHON_ASYNC_TIMEOUT_VERSION = 4.0.0
PYTHON_ASYNC_TIMEOUT_SOURCE = async-timeout-$(PYTHON_ASYNC_TIMEOUT_VERSION).tar.gz
PYTHON_ASYNC_TIMEOUT_SITE = https://files.pythonhosted.org/packages/28/0c/1cd218ea84964f0740a3ab6152dfa99661174abdd8e4053e06c0285ac42a
PYTHON_ASYNC_TIMEOUT_LICENSE = Apache-2.0
PYTHON_ASYNC_TIMEOUT_LICENSE_FILES = LICENSE
PYTHON_ASYNC_TIMEOUT_SETUP_TYPE = setuptools

$(eval $(python-package))
