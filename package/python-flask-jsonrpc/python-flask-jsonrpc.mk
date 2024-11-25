################################################################################
#
# python-flask-jsonrpc
#
################################################################################

PYTHON_FLASK_JSONRPC_VERSION = 3.0.1
PYTHON_FLASK_JSONRPC_SOURCE = Flask-JSONRPC-$(PYTHON_FLASK_JSONRPC_VERSION).tar.gz
PYTHON_FLASK_JSONRPC_SITE = https://files.pythonhosted.org/packages/7e/9d/637a0620802e4c496bd5d48e3766c3a4fd6a03f815f9bcb183bc7a17a5bb
PYTHON_FLASK_JSONRPC_LICENSE = BSD-3-Clause
PYTHON_FLASK_JSONRPC_LICENSE_FILES = LICENSE COPYING
PYTHON_FLASK_JSONRPC_SETUP_TYPE = setuptools

$(eval $(python-package))
