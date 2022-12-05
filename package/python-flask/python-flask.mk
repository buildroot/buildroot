################################################################################
#
# python-flask
#
################################################################################

PYTHON_FLASK_VERSION = 2.2.2
PYTHON_FLASK_SOURCE = Flask-$(PYTHON_FLASK_VERSION).tar.gz
PYTHON_FLASK_SITE = https://files.pythonhosted.org/packages/69/b6/53cfa30eed5aa7343daff36622843688ba8c6fe9829bb2b92e193ab1163f
PYTHON_FLASK_SETUP_TYPE = setuptools
PYTHON_FLASK_LICENSE = BSD-3-Clause
PYTHON_FLASK_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_FLASK_CPE_ID_VENDOR = palletsprojects
PYTHON_FLASK_CPE_ID_PRODUCT = flask

$(eval $(python-package))
