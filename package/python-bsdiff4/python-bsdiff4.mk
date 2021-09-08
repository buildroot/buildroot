################################################################################
#
# python-bsdiff4
#
################################################################################

PYTHON_BSDIFF4_VERSION = 1.2.1
PYTHON_BSDIFF4_SOURCE = bsdiff4-$(PYTHON_BSDIFF4_VERSION).tar.gz
PYTHON_BSDIFF4_SITE = https://files.pythonhosted.org/packages/d8/97/101315b0d8c8d6340ee310484a1af6a2ccf65d7bb4762c3a669cf9457c71
PYTHON_BSDIFF4_LICENSE = BSD-2-Clause, BSD-Protection (core.c)
PYTHON_BSDIFF4_LICENSE_FILES = LICENSE
PYTHON_BSDIFF4_CPE_ID_VENDOR = pypi
PYTHON_BSDIFF4_CPE_ID_PRODUCT = bsdiff4
PYTHON_BSDIFF4_SETUP_TYPE = distutils

$(eval $(python-package))
