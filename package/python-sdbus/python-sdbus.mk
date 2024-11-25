################################################################################
#
# python-sdbus
#
################################################################################

PYTHON_SDBUS_VERSION = 0.13.0
PYTHON_SDBUS_SOURCE = sdbus-$(PYTHON_SDBUS_VERSION).tar.gz
PYTHON_SDBUS_SITE = https://files.pythonhosted.org/packages/4f/c7/8740ff78e9ffdbb9a28e7722e145795015c62ea7ce812242f5968073511c
PYTHON_SDBUS_SETUP_TYPE = setuptools
PYTHON_SDBUS_LICENSE = LGPL-2.1+
PYTHON_SDBUS_LICENSE_FILES = COPYING
PYTHON_SDBUS_DEPENDENCIES = systemd
PYTHON_SDBUS_ENV = CFLAGS="$(TARGET_CFLAGS) -fPIC"

ifeq ($(BR2_STATIC_LIBS),y)
PYTHON_SDBUS_ENV += PYTHON_SDBUS_USE_STATIC_LINK=1
endif

$(eval $(python-package))
