################################################################################
#
# python-wheel
#
################################################################################

PYTHON_WHEEL_VERSION = 0.45.1
PYTHON_WHEEL_SOURCE = wheel-$(PYTHON_WHEEL_VERSION).tar.gz
PYTHON_WHEEL_SITE = https://files.pythonhosted.org/packages/8a/98/2d9906746cdc6a6ef809ae6338005b3f21bb568bea3165cfc6a243fdc25c
PYTHON_WHEEL_SETUP_TYPE = flit
PYTHON_WHEEL_LICENSE = MIT
PYTHON_WHEEL_LICENSE_FILES = LICENSE.txt
PYTHON_WHEEL_CPE_ID_VENDOR = wheel_project
PYTHON_WHEEL_CPE_ID_PRODUCT = wheel

$(eval $(host-python-package))
