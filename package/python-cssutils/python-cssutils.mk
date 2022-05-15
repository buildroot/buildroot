################################################################################
#
# python-cssutils
#
################################################################################

PYTHON_CSSUTILS_VERSION = 2.4.0
PYTHON_CSSUTILS_SOURCE = cssutils-$(PYTHON_CSSUTILS_VERSION).tar.gz
PYTHON_CSSUTILS_SITE = https://files.pythonhosted.org/packages/f4/ea/d09b04b5cf6ad84f45ca4c523d3e153dd9be1f12650c825d1c92ca0618a2
PYTHON_CSSUTILS_LICENSE = LGPL-3.0+
PYTHON_CSSUTILS_LICENSE_FILES = COPYING.LESSER
PYTHON_CSSUTILS_SETUP_TYPE = setuptools
PYTHON_CSSUTILS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
