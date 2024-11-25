################################################################################
#
# python-flask-babel
#
################################################################################

PYTHON_FLASK_BABEL_VERSION = 4.0.0
PYTHON_FLASK_BABEL_SOURCE = flask_babel-$(PYTHON_FLASK_BABEL_VERSION).tar.gz
PYTHON_FLASK_BABEL_SITE = https://files.pythonhosted.org/packages/58/1a/4c65e3b90bda699a637bfb7fb96818b0a9bbff7636ea91aade67f6020a31
PYTHON_FLASK_BABEL_LICENSE = BSD-3-Clause
PYTHON_FLASK_BABEL_SETUP_TYPE = poetry
PYTHON_FLASK_BABEL_LICENSE_FILES = LICENSE

$(eval $(python-package))
