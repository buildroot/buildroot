################################################################################
#
# python-hid
#
################################################################################

PYTHON_HID_VERSION = 1.0.6
PYTHON_HID_SOURCE = hid-$(PYTHON_HID_VERSION).tar.gz
PYTHON_HID_SITE = https://files.pythonhosted.org/packages/50/b8/5f470948262b6cdda8e1b2382b19f67c57eacda1e07a14322807b911e0ce
PYTHON_HID_SETUP_TYPE = setuptools
PYTHON_HID_LICENSE = MIT
PYTHON_HID_LICENSE_FILES = LICENSE

$(eval $(python-package))
