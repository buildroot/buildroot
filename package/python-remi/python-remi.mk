################################################################################
#
# python-remi
#
################################################################################

PYTHON_REMI_VERSION = 2022.7.27-37-g18505f6439849c6e01695dd90dbf680d5ffb0a14
PYTHON_REMI_SITE = $(call github,rawpython,remi,$(PYTHON_REMI_VERSION))

PYTHON_REMI_LICENSE = Apache-2.0
PYTHON_REMI_LICENSE_FILES = LICENSE
PYTHON_REMI_SETUP_TYPE = setuptools

$(eval $(python-package))
