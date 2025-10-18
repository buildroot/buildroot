################################################################################
#
# python-fs
#
################################################################################

PYTHON_FS_VERSION = 2.4.16
PYTHON_FS_SOURCE = fs-$(PYTHON_FS_VERSION).tar.gz
PYTHON_FS_SITE = https://files.pythonhosted.org/packages/5d/a9/af5bfd5a92592c16cdae5c04f68187a309be8a146b528eac3c6e30edbad2
PYTHON_FS_SETUP_TYPE = setuptools
PYTHON_FS_LICENSE = MIT
PYTHON_FS_LICENSE_FILES = LICENSE
HOST_PYTHON_FS_DEPENDENCIES = host-python-six host-python-appdirs

$(eval $(host-python-package))
