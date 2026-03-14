################################################################################
#
# python-wheel
#
################################################################################

PYTHON_WHEEL_VERSION = 0.46.3
PYTHON_WHEEL_SOURCE = wheel-$(PYTHON_WHEEL_VERSION).tar.gz
PYTHON_WHEEL_SITE = https://files.pythonhosted.org/packages/89/24/a2eb353a6edac9a0303977c4cb048134959dd2a51b48a269dfc9dde00c8a
PYTHON_WHEEL_SETUP_TYPE = flit
PYTHON_WHEEL_LICENSE = MIT
PYTHON_WHEEL_LICENSE_FILES = LICENSE.txt
PYTHON_WHEEL_CPE_ID_VENDOR = wheel_project
PYTHON_WHEEL_CPE_ID_PRODUCT = wheel

$(eval $(host-python-package))
