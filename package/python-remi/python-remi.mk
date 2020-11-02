################################################################################
#
# python-remi
#
################################################################################

PYTHON_REMI_VERSION = 2020.10.30
PYTHON_REMI_SITE = $(call github,dddomodossola,remi,$(PYTHON_REMI_VERSION))
PYTHON_REMI_LICENSE = Apache-2.0
PYTHON_REMI_LICENSE_FILES = LICENSE
PYTHON_REMI_SETUP_TYPE = setuptools

$(eval $(python-package))
