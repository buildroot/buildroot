################################################################################
#
# python-zeroconf
#
################################################################################

PYTHON_ZEROCONF_VERSION = 0.29.0
PYTHON_ZEROCONF_SOURCE = zeroconf-$(PYTHON_ZEROCONF_VERSION).tar.gz
PYTHON_ZEROCONF_SITE = https://files.pythonhosted.org/packages/ca/77/eb6137997adc60811c6c46b28b00abac5c16daf14383f61d8a0180326b38
PYTHON_ZEROCONF_SETUP_TYPE = setuptools
PYTHON_ZEROCONF_LICENSE = LGPL-2.1+
PYTHON_ZEROCONF_LICENSE_FILES = COPYING

$(eval $(python-package))
