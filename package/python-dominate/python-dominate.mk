################################################################################
#
# python-dominate
#
################################################################################

PYTHON_DOMINATE_VERSION = 2.9.1
PYTHON_DOMINATE_SOURCE = dominate-$(PYTHON_DOMINATE_VERSION).tar.gz
PYTHON_DOMINATE_SITE = https://files.pythonhosted.org/packages/fb/f3/1c8088ff19a0fcd9c3234802a0ee47006ea64bd8852f1019194f0e3583ff
PYTHON_DOMINATE_SETUP_TYPE = setuptools
PYTHON_DOMINATE_LICENSE = LGPL-3.0+
PYTHON_DOMINATE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
