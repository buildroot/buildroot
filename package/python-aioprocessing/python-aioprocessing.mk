################################################################################
#
# python-aioprocessing
#
################################################################################

PYTHON_AIOPROCESSING_VERSION = 2.0.0
PYTHON_AIOPROCESSING_SOURCE = aioprocessing-$(PYTHON_AIOPROCESSING_VERSION).tar.gz
PYTHON_AIOPROCESSING_SITE = https://files.pythonhosted.org/packages/8e/3e/54266241660fb026bfd27f660d44cd81a4b7f8a145d8e2db010de12622a0
PYTHON_AIOPROCESSING_SETUP_TYPE = setuptools
PYTHON_AIOPROCESSING_LICENSE = BSD-2-Clause
PYTHON_AIOPROCESSING_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
