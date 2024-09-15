################################################################################
#
# python-flask-smorest
#
################################################################################

PYTHON_FLASK_SMOREST_VERSION = 0.44.0
PYTHON_FLASK_SMOREST_SOURCE = flask-smorest-$(PYTHON_FLASK_SMOREST_VERSION).tar.gz
PYTHON_FLASK_SMOREST_SITE = https://files.pythonhosted.org/packages/e7/4f/901bf249e7e19cdfd496247379f58c4ef2f1136c3df0bb542ca0d26a88bd
PYTHON_FLASK_SMOREST_SETUP_TYPE = setuptools
PYTHON_FLASK_SMOREST_LICENSE = MIT
PYTHON_FLASK_SMOREST_LICENSE_FILES = LICENSE

$(eval $(python-package))
