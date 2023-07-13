################################################################################
#
# python-flask-babel
#
################################################################################

PYTHON_FLASK_BABEL_VERSION = 3.1.0
PYTHON_FLASK_BABEL_SOURCE = flask_babel-$(PYTHON_FLASK_BABEL_VERSION).tar.gz
PYTHON_FLASK_BABEL_SITE = https://files.pythonhosted.org/packages/35/83/f31a4ff688168f9c8a73d80ebfc785dcd7703474a0802b25a78d54edd07c
PYTHON_FLASK_BABEL_LICENSE = BSD-3-Clause
PYTHON_FLASK_BABEL_SETUP_TYPE = setuptools
PYTHON_FLASK_BABEL_LICENSE_FILES = LICENSE

$(eval $(python-package))
