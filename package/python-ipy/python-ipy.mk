################################################################################
#
# python-ipy
#
################################################################################

PYTHON_IPY_VERSION = 1.01
PYTHON_IPY_SOURCE = IPy-$(PYTHON_IPY_VERSION).tar.gz
PYTHON_IPY_SITE = https://files.pythonhosted.org/packages/64/a4/9c0d88d95666ff1571d7baec6c5e26abc08051801feb6e6ddf40f6027e22
PYTHON_IPY_LICENSE = BSD-3-Clause
PYTHON_IPY_LICENSE_FILES = COPYING
PYTHON_IPY_SETUP_TYPE = setuptools

$(eval $(python-package))
