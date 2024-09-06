################################################################################
#
# python-dbus-fast
#
################################################################################

PYTHON_DBUS_FAST_VERSION = 2.12.1
PYTHON_DBUS_FAST_SOURCE = dbus_fast-$(PYTHON_DBUS_FAST_VERSION).tar.gz
PYTHON_DBUS_FAST_SITE = https://files.pythonhosted.org/packages/1d/5f/f0757ce529d353739970ebc4a2d9b083b2dcbe0f737fc98706e36f4a0f96
PYTHON_DBUS_FAST_SETUP_TYPE = pep517
PYTHON_DBUS_FAST_LICENSE = MIT
PYTHON_DBUS_FAST_LICENSE_FILES = LICENSE
PYTHON_DBUS_FAST_ENV = REQUIRE_CYTHON=1
PYTHON_DBUS_FAST_DEPENDENCIES = \
	host-python-cython \
	host-python-poetry-core \
	host-python-setuptools

$(eval $(python-package))
