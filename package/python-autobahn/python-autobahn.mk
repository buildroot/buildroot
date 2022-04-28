################################################################################
#
# python-autobahn
#
################################################################################

PYTHON_AUTOBAHN_VERSION = 22.3.2
PYTHON_AUTOBAHN_SOURCE = autobahn-$(PYTHON_AUTOBAHN_VERSION).tar.gz
PYTHON_AUTOBAHN_SITE = https://files.pythonhosted.org/packages/e9/a7/4dea20063b78eb50a54182494ae634cffc0ed6208bf775771f374a9fb8bc
PYTHON_AUTOBAHN_LICENSE = MIT
PYTHON_AUTOBAHN_LICENSE_FILES = LICENSE
PYTHON_AUTOBAHN_CPE_ID_VENDOR = crossbar
PYTHON_AUTOBAHN_CPE_ID_PRODUCT = autobahn
PYTHON_AUTOBAHN_SETUP_TYPE = setuptools
PYTHON_AUTOBAHN_DEPENDENCIES = host-python-cffi
PYTHON_AUTOBAHN_ENV = AUTOBAHN_STRIP_XBR=1

$(eval $(python-package))
