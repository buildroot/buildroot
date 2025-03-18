################################################################################
#
# python-websockets
#
################################################################################

PYTHON_WEBSOCKETS_VERSION = 15.0
PYTHON_WEBSOCKETS_SOURCE = websockets-$(PYTHON_WEBSOCKETS_VERSION).tar.gz
PYTHON_WEBSOCKETS_SITE = https://files.pythonhosted.org/packages/2e/7a/8bc4d15af7ff30f7ba34f9a172063bfcee9f5001d7cef04bee800a658f33
PYTHON_WEBSOCKETS_SETUP_TYPE = setuptools
PYTHON_WEBSOCKETS_LICENSE = BSD-3-Clause
PYTHON_WEBSOCKETS_LICENSE_FILES = LICENSE

$(eval $(python-package))
