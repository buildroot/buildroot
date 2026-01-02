################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 5.0.1
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/df/a0/9c823651872e6a0face3f0311de2a40c8bbcb9c8dcb15680bd019ac56ac7
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = c-ares host-python-cffi
PYTHON_PYCARES_ENV = PYCARES_USE_SYSTEM_LIB=1

$(eval $(python-package))
