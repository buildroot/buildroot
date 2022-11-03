################################################################################
#
# python-zope-interface
#
################################################################################

PYTHON_ZOPE_INTERFACE_VERSION = 5.5.1
PYTHON_ZOPE_INTERFACE_SOURCE = zope.interface-$(PYTHON_ZOPE_INTERFACE_VERSION).tar.gz
PYTHON_ZOPE_INTERFACE_SITE = https://files.pythonhosted.org/packages/c5/ec/3e116b5c3c54f1fb7296a686c110c14d1242bbea17286c487892075d9858
PYTHON_ZOPE_INTERFACE_SETUP_TYPE = setuptools
PYTHON_ZOPE_INTERFACE_LICENSE = ZPL-2.1
PYTHON_ZOPE_INTERFACE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
