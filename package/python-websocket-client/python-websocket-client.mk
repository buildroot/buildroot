################################################################################
#
# python-websocket-client
#
################################################################################

PYTHON_WEBSOCKET_CLIENT_VERSION = 1.8.0
PYTHON_WEBSOCKET_CLIENT_SOURCE = websocket_client-$(PYTHON_WEBSOCKET_CLIENT_VERSION).tar.gz
PYTHON_WEBSOCKET_CLIENT_SITE = https://files.pythonhosted.org/packages/e6/30/fba0d96b4b5fbf5948ed3f4681f7da2f9f64512e1d303f94b4cc174c24a5
PYTHON_WEBSOCKET_CLIENT_SETUP_TYPE = setuptools
PYTHON_WEBSOCKET_CLIENT_LICENSE = Apache-2.0
PYTHON_WEBSOCKET_CLIENT_LICENSE_FILES = LICENSE

$(eval $(python-package))
