################################################################################
#
# python-autobahn
#
################################################################################

PYTHON_AUTOBAHN_VERSION = 26.10.1
PYTHON_AUTOBAHN_SOURCE = autobahn-$(PYTHON_AUTOBAHN_VERSION).tar.gz
PYTHON_AUTOBAHN_SITE = https://files.pythonhosted.org/packages/df/e0/f0a9218a299f0d79feaaf62042812629bb7fa0c1fd6d044a6068ee7f5c79
PYTHON_AUTOBAHN_LICENSE = MIT
PYTHON_AUTOBAHN_LICENSE_FILES = LICENSE
PYTHON_AUTOBAHN_CPE_ID_VENDOR = crossbar
PYTHON_AUTOBAHN_CPE_ID_PRODUCT = autobahn
PYTHON_AUTOBAHN_SETUP_TYPE = hatch
PYTHON_AUTOBAHN_DEPENDENCIES = host-python-cffi host-python-setuptools

$(eval $(python-package))
