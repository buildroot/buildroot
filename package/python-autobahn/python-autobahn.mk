################################################################################
#
# python-autobahn
#
################################################################################

PYTHON_AUTOBAHN_VERSION = 25.12.2
PYTHON_AUTOBAHN_SOURCE = autobahn-$(PYTHON_AUTOBAHN_VERSION).tar.gz
PYTHON_AUTOBAHN_SITE = https://files.pythonhosted.org/packages/54/d5/9adf0f5b9eb244e58e898e9f3db4b00c09835ef4b6c37d491886e0376b4f
PYTHON_AUTOBAHN_LICENSE = MIT
PYTHON_AUTOBAHN_LICENSE_FILES = LICENSE
PYTHON_AUTOBAHN_CPE_ID_VENDOR = crossbar
PYTHON_AUTOBAHN_CPE_ID_PRODUCT = autobahn
PYTHON_AUTOBAHN_SETUP_TYPE = hatch
PYTHON_AUTOBAHN_DEPENDENCIES = host-python-cffi host-python-setuptools

$(eval $(python-package))
