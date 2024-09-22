################################################################################
#
# python-zope-interface
#
################################################################################

PYTHON_ZOPE_INTERFACE_VERSION = 7.0.3
PYTHON_ZOPE_INTERFACE_SOURCE = zope.interface-$(PYTHON_ZOPE_INTERFACE_VERSION).tar.gz
PYTHON_ZOPE_INTERFACE_SITE = https://files.pythonhosted.org/packages/c8/83/7de03efae7fc9a4ec64301d86e29a324f32fe395022e3a5b1a79e376668e
PYTHON_ZOPE_INTERFACE_SETUP_TYPE = setuptools
PYTHON_ZOPE_INTERFACE_LICENSE = ZPL-2.1
PYTHON_ZOPE_INTERFACE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
