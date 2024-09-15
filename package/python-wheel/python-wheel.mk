################################################################################
#
# python-wheel
#
################################################################################

PYTHON_WHEEL_VERSION = 0.44.0
PYTHON_WHEEL_SOURCE = wheel-$(PYTHON_WHEEL_VERSION).tar.gz
PYTHON_WHEEL_SITE = https://files.pythonhosted.org/packages/b7/a0/95e9e962c5fd9da11c1e28aa4c0d8210ab277b1ada951d2aee336b505813
PYTHON_WHEEL_SETUP_TYPE = flit
PYTHON_WHEEL_LICENSE = MIT
PYTHON_WHEEL_LICENSE_FILES = LICENSE.txt
PYTHON_WHEEL_CPE_ID_VENDOR = wheel_project
PYTHON_WHEEL_CPE_ID_PRODUCT = wheel

$(eval $(host-python-package))
