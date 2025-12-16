################################################################################
#
# python-zeroconf
#
################################################################################

PYTHON_ZEROCONF_VERSION = 0.148.0
PYTHON_ZEROCONF_SOURCE = zeroconf-$(PYTHON_ZEROCONF_VERSION).tar.gz
PYTHON_ZEROCONF_SITE = https://files.pythonhosted.org/packages/67/46/10db987799629d01930176ae523f70879b63577060d63e05ebf9214aba4b
PYTHON_ZEROCONF_SETUP_TYPE = poetry
PYTHON_ZEROCONF_LICENSE = LGPL-2.1+
PYTHON_ZEROCONF_LICENSE_FILES = COPYING
PYTHON_ZEROCONF_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
