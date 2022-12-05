################################################################################
#
# python-pyroute2
#
################################################################################

PYTHON_PYROUTE2_VERSION = 0.7.3
PYTHON_PYROUTE2_SOURCE = pyroute2-$(PYTHON_PYROUTE2_VERSION).tar.gz
PYTHON_PYROUTE2_SITE = https://files.pythonhosted.org/packages/9c/e6/8d163b1aea84223696fef8f8c55566adf166b79d614d602469d64af00226
PYTHON_PYROUTE2_LICENSE = Apache-2.0 or GPL-2.0+
PYTHON_PYROUTE2_LICENSE_FILES = LICENSE.Apache-2.0 LICENSE.GPL-2.0-or-later README.license.rst
PYTHON_PYROUTE2_SETUP_TYPE = setuptools

$(eval $(python-package))
