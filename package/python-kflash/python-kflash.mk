################################################################################
#
# python-kflash
#
################################################################################

PYTHON_KFLASH_VERSION = 1.1.6
PYTHON_KFLASH_SOURCE = kflash-$(PYTHON_KFLASH_VERSION).tar.gz
PYTHON_KFLASH_SITE = https://files.pythonhosted.org/packages/4f/80/d2eaa114bf4434b18fcf8960a907ffce12c9400b08c05902b36007d545b7
PYTHON_KFLASH_SETUP_TYPE = setuptools
PYTHON_KFLASH_LICENSE = MIT
PYTHON_KFLASH_LICENSE_FILES = LICENSE
HOST_PYTHON_KFLASH_DEPENDENCIES = host-python-pyelftools host-python-serial

$(eval $(host-python-package))
