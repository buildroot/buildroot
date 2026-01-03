################################################################################
#
# python-bottle
#
################################################################################

PYTHON_BOTTLE_VERSION = 0.13.4
PYTHON_BOTTLE_SOURCE = bottle-$(PYTHON_BOTTLE_VERSION).tar.gz
PYTHON_BOTTLE_SITE = https://files.pythonhosted.org/packages/7a/71/cca6167c06d00c81375fd668719df245864076d284f7cb46a694cbeb5454
PYTHON_BOTTLE_LICENSE = MIT
PYTHON_BOTTLE_LICENSE_FILES = LICENSE
PYTHON_BOTTLE_CPE_ID_VENDOR = bottlepy
PYTHON_BOTTLE_CPE_ID_PRODUCT = bottle
PYTHON_BOTTLE_SETUP_TYPE = setuptools

$(eval $(python-package))
