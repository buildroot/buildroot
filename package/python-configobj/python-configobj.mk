################################################################################
#
# python-configobj
#
################################################################################

PYTHON_CONFIGOBJ_VERSION = 5.0.8
PYTHON_CONFIGOBJ_SOURCE = configobj-$(PYTHON_CONFIGOBJ_VERSION).tar.gz
PYTHON_CONFIGOBJ_SITE = https://files.pythonhosted.org/packages/cb/87/17d4c6d634c044ab08b11c0cd2a8a136d103713d438f8792d7be2c5148fb
PYTHON_CONFIGOBJ_SETUP_TYPE = setuptools
PYTHON_CONFIGOBJ_LICENSE = BSD-3-Clause
PYTHON_CONFIGOBJ_LICENSE_FILES = LICENSE

$(eval $(python-package))
