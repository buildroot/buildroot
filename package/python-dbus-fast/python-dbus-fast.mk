################################################################################
#
# python-dbus-fast
#
################################################################################

PYTHON_DBUS_FAST_VERSION = 2.34.0
PYTHON_DBUS_FAST_SOURCE = dbus_fast-$(PYTHON_DBUS_FAST_VERSION).tar.gz
PYTHON_DBUS_FAST_SITE = https://files.pythonhosted.org/packages/0c/bc/a124a2bcd99063bd07e035b8d82437f152334a459c2497d06f77963f7b95
PYTHON_DBUS_FAST_SETUP_TYPE = poetry
PYTHON_DBUS_FAST_LICENSE = MIT
PYTHON_DBUS_FAST_LICENSE_FILES = LICENSE
PYTHON_DBUS_FAST_ENV = REQUIRE_CYTHON=1
PYTHON_DBUS_FAST_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
