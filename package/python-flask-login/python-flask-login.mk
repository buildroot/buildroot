################################################################################
#
# python-flask-login
#
################################################################################

PYTHON_FLASK_LOGIN_VERSION = 0.6.2
PYTHON_FLASK_LOGIN_SOURCE = Flask-Login-$(PYTHON_FLASK_LOGIN_VERSION).tar.gz
PYTHON_FLASK_LOGIN_SITE = https://files.pythonhosted.org/packages/cc/da/eae45ba9ec58af45b46ef94c6ca04fb211ee57c06421b696e894eb11b064
PYTHON_FLASK_LOGIN_LICENSE = MIT
PYTHON_FLASK_LOGIN_LICENSE_FILES = LICENSE
PYTHON_FLASK_LOGIN_SETUP_TYPE = setuptools

$(eval $(python-package))
