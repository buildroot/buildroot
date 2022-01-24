################################################################################
#
# python-pynacl
#
################################################################################

PYTHON_PYNACL_VERSION = 1.5.0
PYTHON_PYNACL_SOURCE = PyNaCl-$(PYTHON_PYNACL_VERSION).tar.gz
PYTHON_PYNACL_SITE = https://files.pythonhosted.org/packages/a7/22/27582568be639dfe22ddb3902225f91f2f17ceff88ce80e4db396c8986da
PYTHON_PYNACL_LICENSE = Apache-2.0
PYTHON_PYNACL_LICENSE_FILES = LICENSE
PYTHON_PYNACL_SETUP_TYPE = setuptools
PYTHON_PYNACL_DEPENDENCIES = libsodium host-python-cffi
PYTHON_PYNACL_ENV = SODIUM_INSTALL=system

$(eval $(python-package))
