################################################################################
#
# python-autobahn
#
################################################################################

PYTHON_AUTOBAHN_VERSION = 26.7.1
PYTHON_AUTOBAHN_SOURCE = autobahn-$(PYTHON_AUTOBAHN_VERSION).tar.gz
PYTHON_AUTOBAHN_SITE = https://files.pythonhosted.org/packages/de/73/f109f563c27e048e45d135d81af19e6ca391e24905550b06bd1c9d674c57
PYTHON_AUTOBAHN_LICENSE = MIT
PYTHON_AUTOBAHN_LICENSE_FILES = LICENSE
PYTHON_AUTOBAHN_CPE_ID_VENDOR = crossbar
PYTHON_AUTOBAHN_CPE_ID_PRODUCT = autobahn
PYTHON_AUTOBAHN_SETUP_TYPE = hatch
PYTHON_AUTOBAHN_DEPENDENCIES = host-python-cffi host-python-setuptools

$(eval $(python-package))
