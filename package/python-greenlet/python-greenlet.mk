################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 1.1.1
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://files.pythonhosted.org/packages/72/7e/d8586068d47adba73afc085249712bd266cd7ffbf27d8bc260c33e9d6133
PYTHON_GREENLET_SETUP_TYPE = setuptools
PYTHON_GREENLET_LICENSE = MIT, PSF-2.0
PYTHON_GREENLET_LICENSE_FILES = LICENSE LICENSE.PSF

$(eval $(python-package))
