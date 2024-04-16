################################################################################
#
# python-async-timeout
#
################################################################################

PYTHON_ASYNC_TIMEOUT_VERSION = 4.0.3
PYTHON_ASYNC_TIMEOUT_SOURCE = async-timeout-$(PYTHON_ASYNC_TIMEOUT_VERSION).tar.gz
PYTHON_ASYNC_TIMEOUT_SITE = https://files.pythonhosted.org/packages/87/d6/21b30a550dafea84b1b8eee21b5e23fa16d010ae006011221f33dcd8d7f8
PYTHON_ASYNC_TIMEOUT_LICENSE = Apache-2.0
PYTHON_ASYNC_TIMEOUT_LICENSE_FILES = LICENSE
PYTHON_ASYNC_TIMEOUT_SETUP_TYPE = setuptools

$(eval $(python-package))
