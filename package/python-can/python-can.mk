################################################################################
#
# python-can
#
################################################################################

PYTHON_CAN_VERSION = 4.4.2
PYTHON_CAN_SOURCE = python_can-$(PYTHON_CAN_VERSION).tar.gz
PYTHON_CAN_SITE = https://files.pythonhosted.org/packages/a3/17/57c38abbf00993ac5ec306de0c00271685d1372ef3d907b107eb63ab13a8
PYTHON_CAN_SETUP_TYPE = setuptools
PYTHON_CAN_LICENSE = LGPL-3.0
PYTHON_CAN_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
