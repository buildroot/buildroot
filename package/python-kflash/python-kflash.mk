################################################################################
#
# python-kflash
#
################################################################################

PYTHON_KFLASH_VERSION = 1.1.5
PYTHON_KFLASH_SOURCE = kflash-$(PYTHON_KFLASH_VERSION).tar.gz
PYTHON_KFLASH_SITE = https://files.pythonhosted.org/packages/c4/b3/1c25a92922bfd3dbc05d972352c071167cad035c615f6f068f75c2f0fd01
PYTHON_KFLASH_SETUP_TYPE = setuptools
PYTHON_KFLASH_LICENSE = MIT
PYTHON_KFLASH_LICENSE_FILES = LICENSE
HOST_PYTHON_KFLASH_DEPENDENCIES = host-python-pyelftools host-python-serial

$(eval $(host-python-package))
