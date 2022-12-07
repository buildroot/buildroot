################################################################################
#
# python-ifaddr
#
################################################################################

PYTHON_IFADDR_VERSION = 0.2.0
PYTHON_IFADDR_SOURCE = ifaddr-$(PYTHON_IFADDR_VERSION).tar.gz
PYTHON_IFADDR_SITE = https://files.pythonhosted.org/packages/e8/ac/fb4c578f4a3256561548cd825646680edcadb9440f3f68add95ade1eb791
PYTHON_IFADDR_SETUP_TYPE = setuptools
PYTHON_IFADDR_LICENSE = MIT
PYTHON_IFADDR_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
