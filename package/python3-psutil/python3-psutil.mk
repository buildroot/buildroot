################################################################################
#
# python3-psutil
#
################################################################################

# Please keep in sync with package/python-psutil/python-psutil.mk
PYTHON3_PSUTIL_VERSION = 5.8.0
PYTHON3_PSUTIL_SOURCE = psutil-$(PYTHON3_PSUTIL_VERSION).tar.gz
PYTHON3_PSUTIL_SITE = https://files.pythonhosted.org/packages/e1/b0/7276de53321c12981717490516b7e612364f2cb372ee8901bd4a66a000d7
PYTHON3_PSUTIL_SETUP_TYPE = setuptools
PYTHON3_PSUTIL_LICENSE = BSD-3-Clause
PYTHON3_PSUTIL_LICENSE_FILES = LICENSE
PYTHON3_PSUTIL_CPE_ID_VENDOR = psutil_project
PYTHON3_PSUTIL_CPE_ID_PRODUCT = psutil
HOST_PYTHON3_PSUTIL_DL_SUBDIR = python-psutil
HOST_PYTHON3_PSUTIL_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
