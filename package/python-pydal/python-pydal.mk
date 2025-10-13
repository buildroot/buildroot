################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20250922.1
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/f9/94/bf35afe3eaf94e2c411be204b8421b3abb34a24a260513fd9bc0e45c05e4
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
