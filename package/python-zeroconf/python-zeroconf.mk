################################################################################
#
# python-zeroconf
#
################################################################################

PYTHON_ZEROCONF_VERSION = 0.136.0
PYTHON_ZEROCONF_SOURCE = zeroconf-$(PYTHON_ZEROCONF_VERSION).tar.gz
PYTHON_ZEROCONF_SITE = https://files.pythonhosted.org/packages/82/e4/17075a9f1951b031dfd92d57916505574e0d1eab3f2fb7deecabd2be581e
PYTHON_ZEROCONF_SETUP_TYPE = poetry
PYTHON_ZEROCONF_LICENSE = LGPL-2.1+
PYTHON_ZEROCONF_LICENSE_FILES = COPYING
PYTHON_ZEROCONF_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
