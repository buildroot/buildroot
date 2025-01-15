################################################################################
#
# python-pyroute2
#
################################################################################

PYTHON_PYROUTE2_VERSION = 0.8.1
PYTHON_PYROUTE2_SOURCE = pyroute2-$(PYTHON_PYROUTE2_VERSION).tar.gz
PYTHON_PYROUTE2_SITE = https://files.pythonhosted.org/packages/4d/04/c9060b6cb024d05467e17ea93d3ca4bd2f3b05deb2372b7f79321640e8ad
PYTHON_PYROUTE2_LICENSE = Apache-2.0 or GPL-2.0+
PYTHON_PYROUTE2_LICENSE_FILES = LICENSE.Apache-2.0 LICENSE.GPL-2.0-or-later README.license.rst
PYTHON_PYROUTE2_SETUP_TYPE = setuptools

$(eval $(python-package))
