################################################################################
#
# python-flask-smorest
#
################################################################################

PYTHON_FLASK_SMOREST_VERSION = 0.42.1
PYTHON_FLASK_SMOREST_SOURCE = flask-smorest-$(PYTHON_FLASK_SMOREST_VERSION).tar.gz
PYTHON_FLASK_SMOREST_SITE = https://files.pythonhosted.org/packages/be/6e/8e3d0287bfa2da6ca7cf94cd9c053ed209764538dd5fb1d96f535e4d43bb
PYTHON_FLASK_SMOREST_SETUP_TYPE = setuptools
PYTHON_FLASK_SMOREST_LICENSE = MIT
PYTHON_FLASK_SMOREST_LICENSE_FILES = LICENSE

$(eval $(python-package))
