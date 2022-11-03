################################################################################
#
# python-xlib
#
################################################################################

PYTHON_XLIB_VERSION = 0.32
PYTHON_XLIB_SOURCE = python-xlib-$(PYTHON_XLIB_VERSION).tar.gz
PYTHON_XLIB_SITE = https://files.pythonhosted.org/packages/4d/cf/a29ecb43a5c84a65ffd726e3b28806f56b3bc5e796ddb533ff52af107dcf
PYTHON_XLIB_SETUP_TYPE = setuptools
PYTHON_XLIB_LICENSE = LGPL-2.1+
PYTHON_XLIB_LICENSE_FILES = LICENSE
PYTHON_XLIB_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
