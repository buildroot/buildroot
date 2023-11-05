################################################################################
#
# python-flask-cors
#
################################################################################

PYTHON_FLASK_CORS_VERSION = 4.0.0
PYTHON_FLASK_CORS_SOURCE = Flask-Cors-$(PYTHON_FLASK_CORS_VERSION).tar.gz
PYTHON_FLASK_CORS_SITE = https://files.pythonhosted.org/packages/c8/b0/bd7130837a921497520f62023c7ba754e441dcedf959a43e6d1fd86e5451
PYTHON_FLASK_CORS_SETUP_TYPE = setuptools
PYTHON_FLASK_CORS_LICENSE = MIT
PYTHON_FLASK_CORS_LICENSE_FILES = LICENSE
PYTHON_FLASK_CORS_CPE_ID_VENDOR = flask-cors_project
PYTHON_FLASK_CORS_CPE_ID_PRODUCT = flask-cors

$(eval $(python-package))
