################################################################################
#
# python-automat
#
################################################################################

PYTHON_AUTOMAT_VERSION = 24.8.1
PYTHON_AUTOMAT_SOURCE = automat-$(PYTHON_AUTOMAT_VERSION).tar.gz
PYTHON_AUTOMAT_SITE = https://files.pythonhosted.org/packages/8d/2d/ede4ad7fc34ab4482389fa3369d304f2fa22e50770af706678f6a332fa82
PYTHON_AUTOMAT_SETUP_TYPE = setuptools
PYTHON_AUTOMAT_LICENSE = MIT
PYTHON_AUTOMAT_LICENSE_FILES = LICENSE
PYTHON_AUTOMAT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
