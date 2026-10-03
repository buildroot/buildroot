################################################################################
#
# python-flask-cors
#
################################################################################

PYTHON_FLASK_CORS_VERSION = 6.0.5
PYTHON_FLASK_CORS_SOURCE = flask_cors-$(PYTHON_FLASK_CORS_VERSION).tar.gz
PYTHON_FLASK_CORS_SITE = https://files.pythonhosted.org/packages/47/03/4e464a50860f9adf08b5c1d3479cb8ea1f12af2aa69535c7042c6e628135
PYTHON_FLASK_CORS_SETUP_TYPE = setuptools
PYTHON_FLASK_CORS_LICENSE = MIT
PYTHON_FLASK_CORS_CPE_ID_VENDOR = flask-cors_project
PYTHON_FLASK_CORS_CPE_ID_PRODUCT = flask-cors
PYTHON_FLASK_CORS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
