################################################################################
#
# python-psutil
#
################################################################################

PYTHON_PSUTIL_VERSION = 5.9.4
PYTHON_PSUTIL_SOURCE = psutil-$(PYTHON_PSUTIL_VERSION).tar.gz
PYTHON_PSUTIL_SITE = https://files.pythonhosted.org/packages/3d/7d/d05864a69e452f003c0d77e728e155a89a2a26b09e64860ddd70ad64fb26
PYTHON_PSUTIL_SETUP_TYPE = setuptools
PYTHON_PSUTIL_LICENSE = BSD-3-Clause
PYTHON_PSUTIL_LICENSE_FILES = LICENSE
PYTHON_PSUTIL_CPE_ID_VENDOR = psutil_project
PYTHON_PSUTIL_CPE_ID_PRODUCT = psutil

$(eval $(python-package))
$(eval $(host-python-package))
