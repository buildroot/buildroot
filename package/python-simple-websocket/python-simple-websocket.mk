################################################################################
#
# python-simple-websocket
#
################################################################################

PYTHON_SIMPLE_WEBSOCKET_VERSION = 1.0.0
PYTHON_SIMPLE_WEBSOCKET_SOURCE = simple-websocket-$(PYTHON_SIMPLE_WEBSOCKET_VERSION).tar.gz
PYTHON_SIMPLE_WEBSOCKET_SITE = https://files.pythonhosted.org/packages/d3/82/3cf87d317911864a2f2a8daf1779fc7f82d5d55e6a8aaa0315f8209047a7
PYTHON_SIMPLE_WEBSOCKET_SETUP_TYPE = setuptools
PYTHON_SIMPLE_WEBSOCKET_LICENSE = MIT
PYTHON_SIMPLE_WEBSOCKET_LICENSE_FILES = LICENSE

$(eval $(python-package))
