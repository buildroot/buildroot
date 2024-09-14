################################################################################
#
# python-bottle
#
################################################################################

PYTHON_BOTTLE_VERSION = 0.13.1
PYTHON_BOTTLE_SOURCE = bottle-$(PYTHON_BOTTLE_VERSION).tar.gz
PYTHON_BOTTLE_SITE = https://files.pythonhosted.org/packages/87/7e/eae463f832f64b3a1cb640384d155079e7dd2905116ab925e9bb04f66e75
PYTHON_BOTTLE_LICENSE = MIT
PYTHON_BOTTLE_LICENSE_FILES = LICENSE
PYTHON_BOTTLE_CPE_ID_VENDOR = bottlepy
PYTHON_BOTTLE_CPE_ID_PRODUCT = bottle
PYTHON_BOTTLE_SETUP_TYPE = setuptools

$(eval $(python-package))
