################################################################################
#
# python-pyusb
#
################################################################################

PYTHON_PYUSB_VERSION = 1.1.1
PYTHON_PYUSB_SOURCE = pyusb-$(PYTHON_PYUSB_VERSION).tar.gz
PYTHON_PYUSB_SITE = https://files.pythonhosted.org/packages/b9/8d/25c4e446a07e918eb39b5af25c4a83a89db95ae44e4ed5a46c3c53b0a4d6
PYTHON_PYUSB_LICENSE = BSD-3-Clause
PYTHON_PYUSB_LICENSE_FILES = LICENSE
PYTHON_PYUSB_SETUP_TYPE = setuptools
PYTHON_PYUSB_DEPENDENCIES = host-python-setuptools-scm libusb

$(eval $(python-package))
