################################################################################
#
# python-babel
#
################################################################################

PYTHON_BABEL_VERSION = 2.9.1
PYTHON_BABEL_SOURCE = Babel-$(PYTHON_BABEL_VERSION).tar.gz
PYTHON_BABEL_SITE = https://files.pythonhosted.org/packages/17/e6/ec9aa6ac3d00c383a5731cc97ed7c619d3996232c977bb8326bcbb6c687e
PYTHON_BABEL_SETUP_TYPE = setuptools
PYTHON_BABEL_LICENSE = BSD-3-Clause
PYTHON_BABEL_LICENSE_FILES = LICENSE

$(eval $(python-package))
