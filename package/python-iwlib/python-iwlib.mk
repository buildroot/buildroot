################################################################################
#
# python-iwlib
#
################################################################################

PYTHON_IWLIB_VERSION = 1.7.0
PYTHON_IWLIB_SOURCE = iwlib-$(PYTHON_IWLIB_VERSION).tar.gz
PYTHON_IWLIB_SITE = https://files.pythonhosted.org/packages/59/44/fd72c0a7094baeb448dc9e87b3d579da98e2b8593c3fe05c5f9dd20dc6bc
PYTHON_IWLIB_LICENSE = GPL-2.0
PYTHON_IWLIB_LICENSE_FILES = COPYING
PYTHON_IWLIB_SETUP_TYPE = setuptools
PYTHON_IWLIB_DEPENDENCIES = host-python-cffi wireless_tools

$(eval $(python-package))
