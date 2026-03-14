################################################################################
#
# python-hid
#
################################################################################

PYTHON_HID_VERSION = 1.0.9
PYTHON_HID_SOURCE = hid-$(PYTHON_HID_VERSION).tar.gz
PYTHON_HID_SITE = https://files.pythonhosted.org/packages/e9/f8/0357a8aa8874a243e96d08a8568efaf7478293e1a3441ddca18039b690c1
PYTHON_HID_SETUP_TYPE = setuptools
PYTHON_HID_LICENSE = MIT
PYTHON_HID_LICENSE_FILES = LICENSE

$(eval $(python-package))
