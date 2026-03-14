################################################################################
#
# python-flask
#
################################################################################

PYTHON_FLASK_VERSION = 3.1.3
PYTHON_FLASK_SOURCE = flask-$(PYTHON_FLASK_VERSION).tar.gz
PYTHON_FLASK_SITE = https://files.pythonhosted.org/packages/26/00/35d85dcce6c57fdc871f3867d465d780f302a175ea360f62533f12b27e2b
PYTHON_FLASK_SETUP_TYPE = flit
PYTHON_FLASK_LICENSE = BSD-3-Clause
PYTHON_FLASK_LICENSE_FILES = LICENSE.txt docs/license.rst
PYTHON_FLASK_CPE_ID_VENDOR = palletsprojects
PYTHON_FLASK_CPE_ID_PRODUCT = flask

$(eval $(python-package))
