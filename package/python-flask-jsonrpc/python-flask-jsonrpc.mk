################################################################################
#
# python-flask-jsonrpc
#
################################################################################

PYTHON_FLASK_JSONRPC_VERSION = 2.2.2
PYTHON_FLASK_JSONRPC_SOURCE = Flask-JSONRPC-$(PYTHON_FLASK_JSONRPC_VERSION).tar.gz
PYTHON_FLASK_JSONRPC_SITE = https://files.pythonhosted.org/packages/a5/7b/8cbd53084a1efb58a1105905a38b0cbefcd3ae13ef2c90c07eedf0fdb6dc
PYTHON_FLASK_JSONRPC_LICENSE = BSD-3-Clause
PYTHON_FLASK_JSONRPC_LICENSE_FILES = LICENSE COPYING
PYTHON_FLASK_JSONRPC_SETUP_TYPE = setuptools

$(eval $(python-package))
