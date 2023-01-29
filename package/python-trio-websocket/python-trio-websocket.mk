################################################################################
#
# python-trio-websocket
#
################################################################################

PYTHON_TRIO_WEBSOCKET_VERSION = 0.9.2
PYTHON_TRIO_WEBSOCKET_SOURCE = trio-websocket-$(PYTHON_TRIO_WEBSOCKET_VERSION).tar.gz
PYTHON_TRIO_WEBSOCKET_SITE = https://files.pythonhosted.org/packages/75/91/44a0a016025794ba9fef530a6fbe59987153e2cbea7e11fe2f3d8c618740
PYTHON_TRIO_WEBSOCKET_SETUP_TYPE = setuptools
PYTHON_TRIO_WEBSOCKET_LICENSE = MIT

$(eval $(python-package))
