################################################################################
#
# python-hid
#
################################################################################

PYTHON_HID_VERSION = 1.0.8
PYTHON_HID_SOURCE = hid-$(PYTHON_HID_VERSION).tar.gz
PYTHON_HID_SITE = https://files.pythonhosted.org/packages/29/42/9cd3eab530ffae5e0ff880c575fd18cfdfe292b71f1e9872c392329f35fd
PYTHON_HID_SETUP_TYPE = setuptools
PYTHON_HID_LICENSE = MIT
PYTHON_HID_LICENSE_FILES = LICENSE

$(eval $(python-package))
