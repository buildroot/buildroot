################################################################################
#
# python-websocket-client
#
################################################################################

PYTHON_WEBSOCKET_CLIENT_VERSION = 1.4.1
PYTHON_WEBSOCKET_CLIENT_SOURCE = websocket-client-$(PYTHON_WEBSOCKET_CLIENT_VERSION).tar.gz
PYTHON_WEBSOCKET_CLIENT_SITE = https://files.pythonhosted.org/packages/99/11/01fe7ebcb7545a1990c53c11f31230afe1388b0b34256e3fd20e49482245
PYTHON_WEBSOCKET_CLIENT_SETUP_TYPE = setuptools
PYTHON_WEBSOCKET_CLIENT_LICENSE = Apache-2.0
PYTHON_WEBSOCKET_CLIENT_LICENSE_FILES = LICENSE

$(eval $(python-package))
