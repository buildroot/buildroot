################################################################################
#
# python-flask-cors
#
################################################################################

PYTHON_FLASK_CORS_VERSION = 6.0.2
PYTHON_FLASK_CORS_SOURCE = flask_cors-$(PYTHON_FLASK_CORS_VERSION).tar.gz
PYTHON_FLASK_CORS_SITE = https://files.pythonhosted.org/packages/70/74/0fc0fa68d62f21daef41017dafab19ef4b36551521260987eb3a5394c7ba
PYTHON_FLASK_CORS_SETUP_TYPE = setuptools
PYTHON_FLASK_CORS_LICENSE = MIT
PYTHON_FLASK_CORS_CPE_ID_VENDOR = flask-cors_project
PYTHON_FLASK_CORS_CPE_ID_PRODUCT = flask-cors

$(eval $(python-package))
