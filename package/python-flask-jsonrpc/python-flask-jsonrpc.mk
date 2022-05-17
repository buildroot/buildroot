################################################################################
#
# python-flask-jsonrpc
#
################################################################################

PYTHON_FLASK_JSONRPC_VERSION = 2.2.1
PYTHON_FLASK_JSONRPC_SOURCE = Flask-JSONRPC-$(PYTHON_FLASK_JSONRPC_VERSION).tar.gz
PYTHON_FLASK_JSONRPC_SITE = https://files.pythonhosted.org/packages/ca/2a/3f2bd79840d9643fc909cf27f730b2c5006351746ba09c4dab1b898ddee9
PYTHON_FLASK_JSONRPC_LICENSE = BSD-3-Clause
PYTHON_FLASK_JSONRPC_LICENSE_FILES = LICENSE COPYING
PYTHON_FLASK_JSONRPC_SETUP_TYPE = setuptools

$(eval $(python-package))
