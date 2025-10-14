################################################################################
#
# python-trio-websocket
#
################################################################################

PYTHON_TRIO_WEBSOCKET_VERSION = 0.12.2
PYTHON_TRIO_WEBSOCKET_SOURCE = trio_websocket-$(PYTHON_TRIO_WEBSOCKET_VERSION).tar.gz
PYTHON_TRIO_WEBSOCKET_SITE = https://files.pythonhosted.org/packages/d1/3c/8b4358e81f2f2cfe71b66a267f023a91db20a817b9425dd964873796980a
PYTHON_TRIO_WEBSOCKET_SETUP_TYPE = setuptools
PYTHON_TRIO_WEBSOCKET_LICENSE = MIT
PYTHON_TRIO_WEBSOCKET_LICENSE_FILES = LICENSE

$(eval $(python-package))
