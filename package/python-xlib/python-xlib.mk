################################################################################
#
# python-xlib
#
################################################################################

PYTHON_XLIB_VERSION = 0.33
PYTHON_XLIB_SITE = https://files.pythonhosted.org/packages/86/f5/8c0653e5bb54e0cbdfe27bf32d41f27bc4e12faa8742778c17f2a71be2c0
PYTHON_XLIB_SETUP_TYPE = setuptools
PYTHON_XLIB_LICENSE = LGPL-2.1+
PYTHON_XLIB_LICENSE_FILES = LICENSE
PYTHON_XLIB_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
