################################################################################
#
# python-flask-cors
#
################################################################################

PYTHON_FLASK_CORS_VERSION = 6.0.1
PYTHON_FLASK_CORS_SOURCE = flask_cors-$(PYTHON_FLASK_CORS_VERSION).tar.gz
PYTHON_FLASK_CORS_SITE = https://files.pythonhosted.org/packages/76/37/bcfa6c7d5eec777c4c7cf45ce6b27631cebe5230caf88d85eadd63edd37a
PYTHON_FLASK_CORS_SETUP_TYPE = setuptools
PYTHON_FLASK_CORS_LICENSE = MIT
PYTHON_FLASK_CORS_CPE_ID_VENDOR = flask-cors_project
PYTHON_FLASK_CORS_CPE_ID_PRODUCT = flask-cors

$(eval $(python-package))
