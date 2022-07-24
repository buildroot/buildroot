################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.4.9
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/c8/cb/46fb80639cf0dd4251aeb075a1a5e2ebbb8c9656f28ddfe9d8c99b68b6da
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_CPE_ID_VENDOR = python
PYTHON_GNUPG_SETUP_TYPE = setuptools

$(eval $(python-package))
