################################################################################
#
# python-trio-websocket
#
################################################################################

PYTHON_TRIO_WEBSOCKET_VERSION = 0.11.1
PYTHON_TRIO_WEBSOCKET_SOURCE = trio-websocket-$(PYTHON_TRIO_WEBSOCKET_VERSION).tar.gz
PYTHON_TRIO_WEBSOCKET_SITE = https://files.pythonhosted.org/packages/dd/36/abad2385853077424a11b818d9fd8350d249d9e31d583cb9c11cd4c85eda
PYTHON_TRIO_WEBSOCKET_SETUP_TYPE = setuptools
PYTHON_TRIO_WEBSOCKET_LICENSE = MIT
PYTHON_TRIO_WEBSOCKET_LICENSE_FILES = LICENSE

$(eval $(python-package))
