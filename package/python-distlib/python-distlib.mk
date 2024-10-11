################################################################################
#
# python-distlib
#
################################################################################

PYTHON_DISTLIB_VERSION = 0.3.9
PYTHON_DISTLIB_SOURCE = distlib-$(PYTHON_DISTLIB_VERSION).tar.gz
PYTHON_DISTLIB_SITE = https://files.pythonhosted.org/packages/0d/dd/1bec4c5ddb504ca60fc29472f3d27e8d4da1257a854e1d96742f15c1d02d
PYTHON_DISTLIB_SETUP_TYPE = setuptools
PYTHON_DISTLIB_LICENSE = PSF-2.0
PYTHON_DISTLIB_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
