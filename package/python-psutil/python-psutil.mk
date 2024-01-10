################################################################################
#
# python-psutil
#
################################################################################

PYTHON_PSUTIL_VERSION = 5.9.7
PYTHON_PSUTIL_SOURCE = psutil-$(PYTHON_PSUTIL_VERSION).tar.gz
PYTHON_PSUTIL_SITE = https://files.pythonhosted.org/packages/a0/d0/c9ae661a302931735237791f04cb7086ac244377f78692ba3b3eae3a9619
PYTHON_PSUTIL_SETUP_TYPE = setuptools
PYTHON_PSUTIL_LICENSE = BSD-3-Clause
PYTHON_PSUTIL_LICENSE_FILES = LICENSE
PYTHON_PSUTIL_CPE_ID_VENDOR = psutil_project
PYTHON_PSUTIL_CPE_ID_PRODUCT = psutil

$(eval $(python-package))
$(eval $(host-python-package))
