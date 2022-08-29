################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.5.0
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/e3/5c/5ff9877001616912a74f4377cd5f80925b31a678087800beae5b28bdb80e
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_CPE_ID_VENDOR = python
PYTHON_GNUPG_SETUP_TYPE = setuptools

$(eval $(python-package))
