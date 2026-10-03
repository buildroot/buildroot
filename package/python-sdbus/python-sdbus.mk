################################################################################
#
# python-sdbus
#
################################################################################

PYTHON_SDBUS_VERSION = 0.14.3
PYTHON_SDBUS_SOURCE = sdbus-$(PYTHON_SDBUS_VERSION).tar.gz
PYTHON_SDBUS_SITE = https://files.pythonhosted.org/packages/69/0e/14b0f16087cf7f1e1817da9282dcb590fe27030c6ba136c3e35dff647f3a
PYTHON_SDBUS_SETUP_TYPE = setuptools
PYTHON_SDBUS_LICENSE = LGPL-2.1+
PYTHON_SDBUS_LICENSE_FILES = COPYING
PYTHON_SDBUS_DEPENDENCIES = systemd
PYTHON_SDBUS_ENV = CFLAGS="$(TARGET_CFLAGS) -fPIC"

ifeq ($(BR2_STATIC_LIBS),y)
PYTHON_SDBUS_ENV += PYTHON_SDBUS_USE_STATIC_LINK=1
endif

$(eval $(python-package))
