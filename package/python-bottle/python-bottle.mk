################################################################################
#
# python-bottle
#
################################################################################

PYTHON_BOTTLE_VERSION = 0.12.23
PYTHON_BOTTLE_SOURCE = bottle-$(PYTHON_BOTTLE_VERSION).tar.gz
PYTHON_BOTTLE_SITE = https://files.pythonhosted.org/packages/7c/58/75f3765b0a3f86ef0b6e0b23d0503920936752ca6e0fc27efce7403b01bd
PYTHON_BOTTLE_LICENSE = MIT
PYTHON_BOTTLE_LICENSE_FILES = LICENSE
PYTHON_BOTTLE_CPE_ID_VENDOR = bottlepy
PYTHON_BOTTLE_CPE_ID_PRODUCT = bottle
PYTHON_BOTTLE_SETUP_TYPE = setuptools

$(eval $(python-package))
