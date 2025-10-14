################################################################################
#
# python-websockets
#
################################################################################

PYTHON_WEBSOCKETS_VERSION = 15.0.1
PYTHON_WEBSOCKETS_SOURCE = websockets-$(PYTHON_WEBSOCKETS_VERSION).tar.gz
PYTHON_WEBSOCKETS_SITE = https://files.pythonhosted.org/packages/21/e6/26d09fab466b7ca9c7737474c52be4f76a40301b08362eb2dbc19dcc16c1
PYTHON_WEBSOCKETS_SETUP_TYPE = setuptools
PYTHON_WEBSOCKETS_LICENSE = BSD-3-Clause
PYTHON_WEBSOCKETS_LICENSE_FILES = LICENSE

$(eval $(python-package))
