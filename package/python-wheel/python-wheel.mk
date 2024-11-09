################################################################################
#
# python-wheel
#
################################################################################

PYTHON_WHEEL_VERSION = 0.45.0
PYTHON_WHEEL_SOURCE = wheel-$(PYTHON_WHEEL_VERSION).tar.gz
PYTHON_WHEEL_SITE = https://files.pythonhosted.org/packages/e7/52/fd4516fb8f7d11a08e3f9cd69eb1558f098ab67e79f32d920c4974ee550f
PYTHON_WHEEL_SETUP_TYPE = flit
PYTHON_WHEEL_LICENSE = MIT
PYTHON_WHEEL_LICENSE_FILES = LICENSE.txt
PYTHON_WHEEL_CPE_ID_VENDOR = wheel_project
PYTHON_WHEEL_CPE_ID_PRODUCT = wheel

$(eval $(host-python-package))
