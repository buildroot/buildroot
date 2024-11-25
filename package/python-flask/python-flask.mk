################################################################################
#
# python-flask
#
################################################################################

PYTHON_FLASK_VERSION = 3.0.3
PYTHON_FLASK_SOURCE = flask-$(PYTHON_FLASK_VERSION).tar.gz
PYTHON_FLASK_SITE = https://files.pythonhosted.org/packages/41/e1/d104c83026f8d35dfd2c261df7d64738341067526406b40190bc063e829a
PYTHON_FLASK_SETUP_TYPE = flit
PYTHON_FLASK_LICENSE = BSD-3-Clause
PYTHON_FLASK_LICENSE_FILES = LICENSE.txt docs/license.rst
PYTHON_FLASK_CPE_ID_VENDOR = palletsprojects
PYTHON_FLASK_CPE_ID_PRODUCT = flask

$(eval $(python-package))
