################################################################################
#
# python-distlib
#
################################################################################

PYTHON_DISTLIB_VERSION = 0.4.0
PYTHON_DISTLIB_SOURCE = distlib-$(PYTHON_DISTLIB_VERSION).tar.gz
PYTHON_DISTLIB_SITE = https://files.pythonhosted.org/packages/96/8e/709914eb2b5749865801041647dc7f4e6d00b549cfe88b65ca192995f07c
PYTHON_DISTLIB_SETUP_TYPE = setuptools
PYTHON_DISTLIB_LICENSE = PSF-2.0
PYTHON_DISTLIB_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
