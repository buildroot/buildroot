################################################################################
#
# python-zope-interface
#
################################################################################

PYTHON_ZOPE_INTERFACE_VERSION = 8.1.1
PYTHON_ZOPE_INTERFACE_SOURCE = zope_interface-$(PYTHON_ZOPE_INTERFACE_VERSION).tar.gz
PYTHON_ZOPE_INTERFACE_SITE = https://files.pythonhosted.org/packages/71/c9/5ec8679a04d37c797d343f650c51ad67d178f0001c363e44b6ac5f97a9da
PYTHON_ZOPE_INTERFACE_SETUP_TYPE = setuptools
PYTHON_ZOPE_INTERFACE_LICENSE = ZPL-2.1
PYTHON_ZOPE_INTERFACE_LICENSE_FILES = LICENSE.txt
PYTHON_ZOPE_INTERFACE_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
