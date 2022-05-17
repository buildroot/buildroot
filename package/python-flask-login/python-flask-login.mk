################################################################################
#
# python-flask-login
#
################################################################################

PYTHON_FLASK_LOGIN_VERSION = 0.6.1
PYTHON_FLASK_LOGIN_SOURCE = Flask-Login-$(PYTHON_FLASK_LOGIN_VERSION).tar.gz
PYTHON_FLASK_LOGIN_SITE = https://files.pythonhosted.org/packages/3c/0a/e376d599eb6a8999b803a8d390e32451e43a346dbe540350dad48be0069c
PYTHON_FLASK_LOGIN_LICENSE = MIT
PYTHON_FLASK_LOGIN_LICENSE_FILES = LICENSE
PYTHON_FLASK_LOGIN_SETUP_TYPE = setuptools

$(eval $(python-package))
