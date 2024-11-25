################################################################################
#
# python-simple-websocket
#
################################################################################

PYTHON_SIMPLE_WEBSOCKET_VERSION = 1.1.0
PYTHON_SIMPLE_WEBSOCKET_SOURCE = simple_websocket-$(PYTHON_SIMPLE_WEBSOCKET_VERSION).tar.gz
PYTHON_SIMPLE_WEBSOCKET_SITE = https://files.pythonhosted.org/packages/b0/d4/bfa032f961103eba93de583b161f0e6a5b63cebb8f2c7d0c6e6efe1e3d2e
PYTHON_SIMPLE_WEBSOCKET_SETUP_TYPE = setuptools
PYTHON_SIMPLE_WEBSOCKET_LICENSE = MIT
PYTHON_SIMPLE_WEBSOCKET_LICENSE_FILES = LICENSE

$(eval $(python-package))
