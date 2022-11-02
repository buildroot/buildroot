################################################################################
#
# python-babel
#
################################################################################

PYTHON_BABEL_VERSION = 2.11.0
PYTHON_BABEL_SOURCE = Babel-$(PYTHON_BABEL_VERSION).tar.gz
PYTHON_BABEL_SITE = https://files.pythonhosted.org/packages/ff/80/45b42203ecc32c8de281f52e3ec81cb5e4ef16127e9e8543089d8b1649fb
PYTHON_BABEL_SETUP_TYPE = setuptools
PYTHON_BABEL_LICENSE = BSD-3-Clause
PYTHON_BABEL_LICENSE_FILES = LICENSE

$(eval $(python-package))
