################################################################################
#
# python-dbus-fast
#
################################################################################

PYTHON_DBUS_FAST_VERSION = 2.44.1
PYTHON_DBUS_FAST_SOURCE = dbus_fast-$(PYTHON_DBUS_FAST_VERSION).tar.gz
PYTHON_DBUS_FAST_SITE = https://files.pythonhosted.org/packages/c2/a1/9693ec018feed2a7d3420eac6c807eabc6eb84227913104123c0d2ea5737
PYTHON_DBUS_FAST_SETUP_TYPE = poetry
PYTHON_DBUS_FAST_LICENSE = MIT
PYTHON_DBUS_FAST_LICENSE_FILES = LICENSE
PYTHON_DBUS_FAST_ENV = REQUIRE_CYTHON=1
PYTHON_DBUS_FAST_BUILD_OPTS = --skip-dependency-check
PYTHON_DBUS_FAST_DEPENDENCIES = \
	host-python-cython \
	host-python-setuptools

$(eval $(python-package))
