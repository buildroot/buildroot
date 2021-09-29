################################################################################
#
# python-flask-babel
#
################################################################################

PYTHON_FLASK_BABEL_VERSION = 2.0.0
PYTHON_FLASK_BABEL_SOURCE = Flask-Babel-$(PYTHON_FLASK_BABEL_VERSION).tar.gz
PYTHON_FLASK_BABEL_SITE = https://files.pythonhosted.org/packages/d7/fe/655e6a5a99ceb815fe839f0698956a9d6c7d5bcc06ca1ee7c6eb6dac154b
PYTHON_FLASK_BABEL_LICENSE = BSD-3-Clause
PYTHON_FLASK_BABEL_SETUP_TYPE = setuptools
PYTHON_FLASK_BABEL_LICENSE_FILES = LICENSE

$(eval $(python-package))
