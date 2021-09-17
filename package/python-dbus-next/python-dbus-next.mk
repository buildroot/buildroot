################################################################################
#
# python-dbus-next
#
################################################################################

PYTHON_DBUS_NEXT_VERSION = 0.2.3
PYTHON_DBUS_NEXT_SOURCE = dbus_next-$(PYTHON_DBUS_NEXT_VERSION).tar.gz
PYTHON_DBUS_NEXT_SITE = https://files.pythonhosted.org/packages/ce/45/6a40fbe886d60a8c26f480e7d12535502b5ba123814b3b9a0b002ebca198
PYTHON_DBUS_NEXT_SETUP_TYPE = setuptools
PYTHON_DBUS_NEXT_LICENSE = MIT
PYTHON_DBUS_NEXT_LICENSE_FILES = LICENSE

$(eval $(python-package))
