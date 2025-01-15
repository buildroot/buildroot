################################################################################
#
# python-dbus-fast
#
################################################################################

PYTHON_DBUS_FAST_VERSION = 2.28.0
PYTHON_DBUS_FAST_SOURCE = dbus_fast-$(PYTHON_DBUS_FAST_VERSION).tar.gz
PYTHON_DBUS_FAST_SITE = https://files.pythonhosted.org/packages/fb/a1/b7bd68329a6f3afc833d5a3d8eeed5f0557cd80e065f3cfbfd5df7193da2
PYTHON_DBUS_FAST_SETUP_TYPE = poetry
PYTHON_DBUS_FAST_LICENSE = MIT
PYTHON_DBUS_FAST_LICENSE_FILES = LICENSE
PYTHON_DBUS_FAST_ENV = REQUIRE_CYTHON=1
PYTHON_DBUS_FAST_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
