################################################################################
#
# python-pynacl
#
################################################################################

PYTHON_PYNACL_VERSION = 1.6.0
PYTHON_PYNACL_SOURCE = pynacl-$(PYTHON_PYNACL_VERSION).tar.gz
PYTHON_PYNACL_SITE = https://files.pythonhosted.org/packages/06/c6/a3124dee667a423f2c637cfd262a54d67d8ccf3e160f3c50f622a85b7723
PYTHON_PYNACL_LICENSE = Apache-2.0
PYTHON_PYNACL_LICENSE_FILES = LICENSE
PYTHON_PYNACL_SETUP_TYPE = setuptools
PYTHON_PYNACL_DEPENDENCIES = libsodium host-python-cffi
PYTHON_PYNACL_ENV = SODIUM_INSTALL=system

$(eval $(python-package))
