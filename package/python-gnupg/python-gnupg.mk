################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.5.3
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/85/61/2df3cd6f49dbb2d4a6a567cac1d803e3a50d86207e196d0f9e67a48664f7
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_CPE_ID_VENDOR = python
PYTHON_GNUPG_SETUP_TYPE = setuptools

$(eval $(python-package))
