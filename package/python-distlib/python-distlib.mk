################################################################################
#
# python-distlib
#
################################################################################

PYTHON_DISTLIB_VERSION = 0.3.8
PYTHON_DISTLIB_SOURCE = distlib-$(PYTHON_DISTLIB_VERSION).tar.gz
PYTHON_DISTLIB_SITE = https://files.pythonhosted.org/packages/c4/91/e2df406fb4efacdf46871c25cde65d3c6ee5e173b7e5a4547a47bae91920
PYTHON_DISTLIB_SETUP_TYPE = setuptools
PYTHON_DISTLIB_LICENSE = PSF-2.0
PYTHON_DISTLIB_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
