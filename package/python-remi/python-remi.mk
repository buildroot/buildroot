################################################################################
#
# python-remi
#
################################################################################

PYTHON_REMI_VERSION = 2022.7.27
PYTHON_REMI_SOURCE = remi-$(PYTHON_REMI_VERSION).tar.gz
PYTHON_REMI_SITE = https://files.pythonhosted.org/packages/b7/5c/fca9d9273fc9d5f4ca0bc2f387ca19f8ba9979dcb75617d094e575dc2337

PYTHON_REMI_LICENSE = Apache-2.0
PYTHON_REMI_LICENSE_FILES = LICENSE
PYTHON_REMI_SETUP_TYPE = setuptools

$(eval $(python-package))
