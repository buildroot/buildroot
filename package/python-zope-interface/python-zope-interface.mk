################################################################################
#
# python-zope-interface
#
################################################################################

PYTHON_ZOPE_INTERFACE_VERSION = 8.2
PYTHON_ZOPE_INTERFACE_SOURCE = zope_interface-$(PYTHON_ZOPE_INTERFACE_VERSION).tar.gz
PYTHON_ZOPE_INTERFACE_SITE = https://files.pythonhosted.org/packages/86/a4/77daa5ba398996d16bb43fc721599d27d03eae68fe3c799de1963c72e228
PYTHON_ZOPE_INTERFACE_SETUP_TYPE = setuptools
PYTHON_ZOPE_INTERFACE_LICENSE = ZPL-2.1
PYTHON_ZOPE_INTERFACE_LICENSE_FILES = LICENSE.txt
PYTHON_ZOPE_INTERFACE_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
