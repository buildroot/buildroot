################################################################################
#
# python-zeroconf
#
################################################################################

PYTHON_ZEROCONF_VERSION = 0.153.0
PYTHON_ZEROCONF_SOURCE = zeroconf-$(PYTHON_ZEROCONF_VERSION).tar.gz
PYTHON_ZEROCONF_SITE = https://files.pythonhosted.org/packages/c2/ad/e321ee148e871fdb257e9fd5840748d06a72db132815ecb47d42d13b1a3a
PYTHON_ZEROCONF_SETUP_TYPE = poetry
PYTHON_ZEROCONF_LICENSE = LGPL-2.1+
PYTHON_ZEROCONF_LICENSE_FILES = COPYING
PYTHON_ZEROCONF_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
