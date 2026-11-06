################################################################################
#
# python-bsdiff4
#
################################################################################

PYTHON_BSDIFF4_VERSION = 1.4.2
PYTHON_BSDIFF4_SOURCE = bsdiff4-$(PYTHON_BSDIFF4_VERSION).tar.gz
PYTHON_BSDIFF4_SITE = https://files.pythonhosted.org/packages/ae/89/6933ddf0a7d1d117a1c4c8e33b893c686935a8b392e36a8ae098189faed8
PYTHON_BSDIFF4_LICENSE = BSD-2-Clause, BSD-Protection (core.c)
PYTHON_BSDIFF4_LICENSE_FILES = LICENSE
PYTHON_BSDIFF4_CPE_ID_VENDOR = pypi
PYTHON_BSDIFF4_CPE_ID_PRODUCT = bsdiff4
PYTHON_BSDIFF4_SETUP_TYPE = setuptools

$(eval $(python-package))
