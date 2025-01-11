################################################################################
#
# python-zeroconf
#
################################################################################

PYTHON_ZEROCONF_VERSION = 0.139.0
PYTHON_ZEROCONF_SOURCE = zeroconf-$(PYTHON_ZEROCONF_VERSION).tar.gz
PYTHON_ZEROCONF_SITE = https://files.pythonhosted.org/packages/5e/77/1db96e97567a1ffd8393a42959fa783ef66fc91d19ac9f7c75fd3be14661
PYTHON_ZEROCONF_SETUP_TYPE = poetry
PYTHON_ZEROCONF_LICENSE = LGPL-2.1+
PYTHON_ZEROCONF_LICENSE_FILES = COPYING
PYTHON_ZEROCONF_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
