################################################################################
#
# python-pyusb
#
################################################################################

PYTHON_PYUSB_VERSION = 1.2.1
PYTHON_PYUSB_SOURCE = pyusb-$(PYTHON_PYUSB_VERSION).tar.gz
PYTHON_PYUSB_SITE = https://files.pythonhosted.org/packages/d9/6e/433a5614132576289b8643fe598dd5d51b16e130fd591564be952e15bb45
PYTHON_PYUSB_LICENSE = BSD-3-Clause
PYTHON_PYUSB_LICENSE_FILES = LICENSE
PYTHON_PYUSB_SETUP_TYPE = setuptools
PYTHON_PYUSB_DEPENDENCIES = host-python-setuptools-scm libusb

$(eval $(python-package))
