################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.5.6
PYTHON_GNUPG_SOURCE = python_gnupg-$(PYTHON_GNUPG_VERSION).tar.gz
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/98/2c/6cd2c7cff4bdbb434be5429ef6b8e96ee6b50155551361f30a1bb2ea3c1d
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_CPE_ID_VENDOR = python
PYTHON_GNUPG_SETUP_TYPE = setuptools

$(eval $(python-package))
