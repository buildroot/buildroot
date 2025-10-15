################################################################################
#
# python-sdbus
#
################################################################################

PYTHON_SDBUS_VERSION = 0.14.1.post0
PYTHON_SDBUS_SOURCE = sdbus-$(PYTHON_SDBUS_VERSION).tar.gz
PYTHON_SDBUS_SITE = https://files.pythonhosted.org/packages/b9/4f/549089131ba4ba5379517655cdcbfe3925fd1cc0eafd93aac5f73c2a6d40
PYTHON_SDBUS_SETUP_TYPE = setuptools
PYTHON_SDBUS_LICENSE = LGPL-2.1+
PYTHON_SDBUS_LICENSE_FILES = COPYING
PYTHON_SDBUS_DEPENDENCIES = systemd
PYTHON_SDBUS_ENV = CFLAGS="$(TARGET_CFLAGS) -fPIC"

ifeq ($(BR2_STATIC_LIBS),y)
PYTHON_SDBUS_ENV += PYTHON_SDBUS_USE_STATIC_LINK=1
endif

$(eval $(python-package))
