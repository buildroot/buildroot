################################################################################
#
# python-cssutils
#
################################################################################

PYTHON_CSSUTILS_VERSION = 2.9.0
PYTHON_CSSUTILS_SOURCE = cssutils-$(PYTHON_CSSUTILS_VERSION).tar.gz
PYTHON_CSSUTILS_SITE = https://files.pythonhosted.org/packages/b4/65/a054545c81eb87af898d664043578b8444ea3ded656db3da8f9d9fa21334
PYTHON_CSSUTILS_LICENSE = LGPL-3.0+
PYTHON_CSSUTILS_LICENSE_FILES = COPYING.LESSER
PYTHON_CSSUTILS_SETUP_TYPE = setuptools
PYTHON_CSSUTILS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
