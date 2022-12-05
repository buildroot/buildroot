################################################################################
#
# python-dominate
#
################################################################################

PYTHON_DOMINATE_VERSION = 2.7.0
PYTHON_DOMINATE_SOURCE = dominate-$(PYTHON_DOMINATE_VERSION).tar.gz
PYTHON_DOMINATE_SITE = https://files.pythonhosted.org/packages/12/d7/5e5f50f5d5bdd4282d2a70b9479c1d91d6628bebd4829e455cdf7366a92e
PYTHON_DOMINATE_SETUP_TYPE = setuptools
PYTHON_DOMINATE_LICENSE = LGPL-3.0+
PYTHON_DOMINATE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
