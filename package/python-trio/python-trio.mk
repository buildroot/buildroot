################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.28.0
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/b3/73/57efab729506a8d4b89814f1e356ec8f3369de0ed4fd7e7616974d09646d
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
