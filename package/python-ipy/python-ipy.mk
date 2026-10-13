################################################################################
#
# python-ipy
#
################################################################################

PYTHON_IPY_VERSION = 1.2
PYTHON_IPY_SOURCE = ipy-$(PYTHON_IPY_VERSION).tar.gz
PYTHON_IPY_SITE = https://files.pythonhosted.org/packages/d1/49/de558c2c8581f5860b9696467fb893c7141501daf00ea14bb01fefd360e1
PYTHON_IPY_LICENSE = BSD-3-Clause
PYTHON_IPY_LICENSE_FILES = COPYING
PYTHON_IPY_SETUP_TYPE = setuptools

$(eval $(python-package))
