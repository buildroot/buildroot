################################################################################
#
# python-psutil
#
################################################################################

PYTHON_PSUTIL_VERSION = 6.1.1
PYTHON_PSUTIL_SOURCE = psutil-$(PYTHON_PSUTIL_VERSION).tar.gz
PYTHON_PSUTIL_SITE = https://files.pythonhosted.org/packages/1f/5a/07871137bb752428aa4b659f910b399ba6f291156bdea939be3e96cae7cb
PYTHON_PSUTIL_SETUP_TYPE = setuptools
PYTHON_PSUTIL_LICENSE = BSD-3-Clause
PYTHON_PSUTIL_LICENSE_FILES = LICENSE
PYTHON_PSUTIL_CPE_ID_VENDOR = psutil_project
PYTHON_PSUTIL_CPE_ID_PRODUCT = psutil

$(eval $(python-package))
$(eval $(host-python-package))
