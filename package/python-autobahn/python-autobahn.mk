################################################################################
#
# python-autobahn
#
################################################################################

PYTHON_AUTOBAHN_VERSION = 22.7.1
PYTHON_AUTOBAHN_SOURCE = autobahn-$(PYTHON_AUTOBAHN_VERSION).tar.gz
PYTHON_AUTOBAHN_SITE = https://files.pythonhosted.org/packages/c5/b5/c92d6640fd55cbbdd97c05800ab534d84197f7b485d89a9df981ab67cce3
PYTHON_AUTOBAHN_LICENSE = MIT
PYTHON_AUTOBAHN_LICENSE_FILES = LICENSE
PYTHON_AUTOBAHN_CPE_ID_VENDOR = crossbar
PYTHON_AUTOBAHN_CPE_ID_PRODUCT = autobahn
PYTHON_AUTOBAHN_SETUP_TYPE = setuptools
PYTHON_AUTOBAHN_DEPENDENCIES = host-python-cffi
PYTHON_AUTOBAHN_ENV = AUTOBAHN_STRIP_XBR=1

$(eval $(python-package))
