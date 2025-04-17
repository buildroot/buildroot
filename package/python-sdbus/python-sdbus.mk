################################################################################
#
# python-sdbus
#
################################################################################

PYTHON_SDBUS_VERSION = 0.14.0
PYTHON_SDBUS_SOURCE = sdbus-$(PYTHON_SDBUS_VERSION).tar.gz
PYTHON_SDBUS_SITE = https://files.pythonhosted.org/packages/17/9a/1dc010428fa1f444809d9aa1adb3ce231dae891b5f33635d8f4d7a8e33fd
PYTHON_SDBUS_SETUP_TYPE = setuptools
PYTHON_SDBUS_LICENSE = LGPL-2.1+
PYTHON_SDBUS_LICENSE_FILES = COPYING
PYTHON_SDBUS_DEPENDENCIES = systemd
PYTHON_SDBUS_ENV = CFLAGS="$(TARGET_CFLAGS) -fPIC"

ifeq ($(BR2_STATIC_LIBS),y)
PYTHON_SDBUS_ENV += PYTHON_SDBUS_USE_STATIC_LINK=1
endif

$(eval $(python-package))
