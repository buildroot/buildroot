################################################################################
#
# python-dbus-next
#
################################################################################

PYTHON_DBUS_NEXT_VERSION = 0.2.2
PYTHON_DBUS_NEXT_SOURCE = dbus_next-$(PYTHON_DBUS_NEXT_VERSION).tar.gz
PYTHON_DBUS_NEXT_SITE = https://files.pythonhosted.org/packages/cb/fb/5ab0485c6460e39be75e16af95c0e23c2531c1ac5a482fffb9ee7d576e6f
PYTHON_DBUS_NEXT_SETUP_TYPE = setuptools
PYTHON_DBUS_NEXT_LICENSE = MIT
PYTHON_DBUS_NEXT_LICENSE_FILES = LICENSE

$(eval $(python-package))
