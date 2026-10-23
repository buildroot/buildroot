################################################################################
#
# python-bsdiff4
#
################################################################################

PYTHON_BSDIFF4_VERSION = 1.3.1
PYTHON_BSDIFF4_SOURCE = bsdiff4-$(PYTHON_BSDIFF4_VERSION).tar.gz
PYTHON_BSDIFF4_SITE = https://files.pythonhosted.org/packages/2b/3c/62c66de04e2ff09a3a3d56e4fc8a616177d481ae6c509363d178d2509690
PYTHON_BSDIFF4_LICENSE = BSD-2-Clause, BSD-Protection (core.c)
PYTHON_BSDIFF4_LICENSE_FILES = LICENSE
PYTHON_BSDIFF4_CPE_ID_VENDOR = pypi
PYTHON_BSDIFF4_CPE_ID_PRODUCT = bsdiff4
PYTHON_BSDIFF4_SETUP_TYPE = setuptools

$(eval $(python-package))
