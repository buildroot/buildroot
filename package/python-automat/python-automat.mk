################################################################################
#
# python-automat
#
################################################################################

PYTHON_AUTOMAT_VERSION = 22.10.0
PYTHON_AUTOMAT_SOURCE = Automat-$(PYTHON_AUTOMAT_VERSION).tar.gz
PYTHON_AUTOMAT_SITE = https://files.pythonhosted.org/packages/7a/7b/9c3d26d8a0416eefbc0428f168241b32657ca260fb7ef507596ff5c2f6c4
PYTHON_AUTOMAT_SETUP_TYPE = setuptools
PYTHON_AUTOMAT_LICENSE = MIT
PYTHON_AUTOMAT_LICENSE_FILES = LICENSE
PYTHON_AUTOMAT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
