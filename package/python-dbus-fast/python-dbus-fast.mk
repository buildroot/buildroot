################################################################################
#
# python-dbus-fast
#
################################################################################

PYTHON_DBUS_FAST_VERSION = 2.24.4
PYTHON_DBUS_FAST_SOURCE = dbus_fast-$(PYTHON_DBUS_FAST_VERSION).tar.gz
PYTHON_DBUS_FAST_SITE = https://files.pythonhosted.org/packages/1f/91/b04e2dca706bddcd419352b5f623e8860c04adf2dd6ceef6116df4de4f6a
PYTHON_DBUS_FAST_SETUP_TYPE = poetry
PYTHON_DBUS_FAST_LICENSE = MIT
PYTHON_DBUS_FAST_LICENSE_FILES = LICENSE
PYTHON_DBUS_FAST_ENV = REQUIRE_CYTHON=1
PYTHON_DBUS_FAST_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
