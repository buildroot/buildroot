################################################################################
#
# python-bsdiff4
#
################################################################################

PYTHON_BSDIFF4_VERSION = 1.2.2
PYTHON_BSDIFF4_SOURCE = bsdiff4-$(PYTHON_BSDIFF4_VERSION).tar.gz
PYTHON_BSDIFF4_SITE = https://files.pythonhosted.org/packages/34/e2/e28dd282974f919a6b9adb3b7e64bb1fa4390046706c3e58a60b94aeb497
PYTHON_BSDIFF4_LICENSE = BSD-2-Clause, BSD-Protection (core.c)
PYTHON_BSDIFF4_LICENSE_FILES = LICENSE
PYTHON_BSDIFF4_CPE_ID_VENDOR = pypi
PYTHON_BSDIFF4_CPE_ID_PRODUCT = bsdiff4
PYTHON_BSDIFF4_SETUP_TYPE = setuptools

$(eval $(python-package))
