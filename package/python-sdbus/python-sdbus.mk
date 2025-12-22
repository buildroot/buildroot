################################################################################
#
# python-sdbus
#
################################################################################

PYTHON_SDBUS_VERSION = 0.14.2
PYTHON_SDBUS_SOURCE = sdbus-$(PYTHON_SDBUS_VERSION).tar.gz
PYTHON_SDBUS_SITE = https://files.pythonhosted.org/packages/7c/0f/0cf6b2fb0338fb3ab564cb8a8d68aa1c6de767851f5f9de9a3c83dbabeab
PYTHON_SDBUS_SETUP_TYPE = setuptools
PYTHON_SDBUS_LICENSE = LGPL-2.1+
PYTHON_SDBUS_LICENSE_FILES = COPYING
PYTHON_SDBUS_DEPENDENCIES = systemd
PYTHON_SDBUS_ENV = CFLAGS="$(TARGET_CFLAGS) -fPIC"

ifeq ($(BR2_STATIC_LIBS),y)
PYTHON_SDBUS_ENV += PYTHON_SDBUS_USE_STATIC_LINK=1
endif

$(eval $(python-package))
