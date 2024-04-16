################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.5.2
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/b1/5d/4425390ad81d22b330a1b0df204c4d39fb3cb7c39e081d51e9f7426ce716
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_CPE_ID_VENDOR = python
PYTHON_GNUPG_SETUP_TYPE = setuptools

$(eval $(python-package))
