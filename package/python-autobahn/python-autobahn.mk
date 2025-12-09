################################################################################
#
# python-autobahn
#
################################################################################

PYTHON_AUTOBAHN_VERSION = 25.11.1
PYTHON_AUTOBAHN_SOURCE = autobahn-$(PYTHON_AUTOBAHN_VERSION).tar.gz
PYTHON_AUTOBAHN_SITE = https://files.pythonhosted.org/packages/0e/3a/aab5632fbd88ed26d330ab156af80c9a90419dfa2841296fd556a65e5fac
PYTHON_AUTOBAHN_LICENSE = MIT
PYTHON_AUTOBAHN_LICENSE_FILES = LICENSE
PYTHON_AUTOBAHN_CPE_ID_VENDOR = crossbar
PYTHON_AUTOBAHN_CPE_ID_PRODUCT = autobahn
PYTHON_AUTOBAHN_SETUP_TYPE = setuptools
PYTHON_AUTOBAHN_DEPENDENCIES = host-python-cffi
PYTHON_AUTOBAHN_ENV = AUTOBAHN_STRIP_XBR=1

$(eval $(python-package))
