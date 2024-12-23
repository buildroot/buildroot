################################################################################
#
# python-flask
#
################################################################################

PYTHON_FLASK_VERSION = 3.1.0
PYTHON_FLASK_SOURCE = flask-$(PYTHON_FLASK_VERSION).tar.gz
PYTHON_FLASK_SITE = https://files.pythonhosted.org/packages/89/50/dff6380f1c7f84135484e176e0cac8690af72fa90e932ad2a0a60e28c69b
PYTHON_FLASK_SETUP_TYPE = flit
PYTHON_FLASK_LICENSE = BSD-3-Clause
PYTHON_FLASK_LICENSE_FILES = LICENSE.txt docs/license.rst
PYTHON_FLASK_CPE_ID_VENDOR = palletsprojects
PYTHON_FLASK_CPE_ID_PRODUCT = flask

$(eval $(python-package))
