################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 5.2.1
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/c9/f3/4df974f2f902fdcec81087773f37eaedc7c8308291fb3f15da7ff21a5b88
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = c-ares host-python-cffi
PYTHON_PYCARES_ENV = PYCARES_USE_SYSTEM_LIB=1

$(eval $(python-package))
