################################################################################
#
# python-dbus-fast
#
################################################################################

PYTHON_DBUS_FAST_VERSION = 2.7.0
PYTHON_DBUS_FAST_SOURCE = dbus_fast-$(PYTHON_DBUS_FAST_VERSION).tar.gz
PYTHON_DBUS_FAST_SITE = https://files.pythonhosted.org/packages/e5/ba/beeaf36821f0164a208e8cbe9adbdc75ce0a6eafdebd4011912a806a4275
PYTHON_DBUS_FAST_SETUP_TYPE = setuptools
PYTHON_DBUS_FAST_LICENSE = MIT
PYTHON_DBUS_FAST_LICENSE_FILES = LICENSE
PYTHON_DBUS_FAST_ENV = REQUIRE_CYTHON=1
PYTHON_DBUS_FAST_DEPENDENCIES = host-python-cython

$(eval $(python-package))
