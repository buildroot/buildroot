################################################################################
#
# python-pyusb
#
################################################################################

PYTHON_PYUSB_VERSION = 1.3.1
PYTHON_PYUSB_SOURCE = pyusb-$(PYTHON_PYUSB_VERSION).tar.gz
PYTHON_PYUSB_SITE = https://files.pythonhosted.org/packages/00/6b/ce3727395e52b7b76dfcf0c665e37d223b680b9becc60710d4bc08b7b7cb
PYTHON_PYUSB_LICENSE = BSD-3-Clause
PYTHON_PYUSB_LICENSE_FILES = LICENSE
PYTHON_PYUSB_SETUP_TYPE = setuptools
PYTHON_PYUSB_DEPENDENCIES = host-python-setuptools-scm libusb

$(eval $(python-package))
