################################################################################
#
# python-flask-jsonrpc
#
################################################################################

PYTHON_FLASK_JSONRPC_VERSION = 4.0.0
PYTHON_FLASK_JSONRPC_SOURCE = flask_jsonrpc-$(PYTHON_FLASK_JSONRPC_VERSION).tar.gz
PYTHON_FLASK_JSONRPC_SITE = https://files.pythonhosted.org/packages/b9/2e/74dcb729aa2f5b49d4731cfaab5cb5fbfd867906ba7a0a6e32c66779dbb6
PYTHON_FLASK_JSONRPC_LICENSE = BSD-3-Clause
PYTHON_FLASK_JSONRPC_LICENSE_FILES = LICENSE.txt
PYTHON_FLASK_JSONRPC_SETUP_TYPE = hatch

$(eval $(python-package))
