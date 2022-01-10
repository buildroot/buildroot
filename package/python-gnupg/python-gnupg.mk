################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.4.8
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/b1/90/75e15ead9693028c05fc7abd25c756c0d1da27bf04a27d6f5c4139d8ee10
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_SETUP_TYPE = setuptools

$(eval $(python-package))
