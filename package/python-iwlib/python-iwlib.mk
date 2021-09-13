################################################################################
#
# python-iwlib
#
################################################################################

PYTHON_IWLIB_VERSION = 1.5
PYTHON_IWLIB_SITE = $(call github,nhoad,python-iwlib,$(PYTHON_IWLIB_VERSION))
PYTHON_IWLIB_LICENSE = GPL-2.0
PYTHON_IWLIB_LICENSE_FILES = COPYING
PYTHON_IWLIB_SETUP_TYPE = setuptools
PYTHON_IWLIB_DEPENDENCIES = wireless_tools

$(eval $(python-package))
