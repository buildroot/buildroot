################################################################################
#
# python-cssutils
#
################################################################################

PYTHON_CSSUTILS_VERSION = 2.5.1
PYTHON_CSSUTILS_SOURCE = cssutils-$(PYTHON_CSSUTILS_VERSION).tar.gz
PYTHON_CSSUTILS_SITE = https://files.pythonhosted.org/packages/bd/f0/d3a02af54f292fe9d1f6bb18c7d2f79992b5cbae0db1ee91e5c73a3c7d7c
PYTHON_CSSUTILS_LICENSE = LGPL-3.0+
PYTHON_CSSUTILS_LICENSE_FILES = COPYING.LESSER
PYTHON_CSSUTILS_SETUP_TYPE = setuptools
PYTHON_CSSUTILS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
