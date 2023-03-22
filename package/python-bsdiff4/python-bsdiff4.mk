################################################################################
#
# python-bsdiff4
#
################################################################################

PYTHON_BSDIFF4_VERSION = 1.2.3
PYTHON_BSDIFF4_SOURCE = bsdiff4-$(PYTHON_BSDIFF4_VERSION).tar.gz
PYTHON_BSDIFF4_SITE = https://files.pythonhosted.org/packages/a8/0e/a677b62d35e3a9d074eafb5b16b569d5d6870a6ead02e8c830e4d4e73db7
PYTHON_BSDIFF4_LICENSE = BSD-2-Clause, BSD-Protection (core.c)
PYTHON_BSDIFF4_LICENSE_FILES = LICENSE
PYTHON_BSDIFF4_CPE_ID_VENDOR = pypi
PYTHON_BSDIFF4_CPE_ID_PRODUCT = bsdiff4
PYTHON_BSDIFF4_SETUP_TYPE = setuptools

$(eval $(python-package))
