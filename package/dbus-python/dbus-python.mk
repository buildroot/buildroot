################################################################################
#
# dbus-python
#
################################################################################

DBUS_PYTHON_VERSION = 1.5.0
DBUS_PYTHON_SOURCE = dbus_python-$(DBUS_PYTHON_VERSION).tar.gz
DBUS_PYTHON_SITE = https://dbus.freedesktop.org/releases/dbus-python
DBUS_PYTHON_INSTALL_STAGING = YES
DBUS_PYTHON_LICENSE = MIT (dbus-python), AFL-2.1 or GPL-2.0+ (dbus-gmain)
DBUS_PYTHON_LICENSE_FILES = \
	COPYING \
	LICENSES/MIT.txt \
	subprojects/dbus-gmain/COPYING \
	subprojects/dbus-gmain/LICENSES/AFL-2.1.txt \
	subprojects/dbus-gmain/LICENSES/GPL-2.0-or-later.txt \
	subprojects/dbus-gmain/LICENSES/MIT.txt
DBUS_PYTHON_DEPENDENCIES = dbus libglib2 python3 host-python3
HOST_DBUS_PYTHON_DEPENDENCIES = host-dbus host-libglib2 host-python3

DBUS_PYTHON_CONF_ENV = \
	_PYTHON_SYSCONFIGDATA_NAME=$(PKG_PYTHON_SYSCONFIGDATA_NAME) \
	PYTHONPATH=$(PYTHON3_PATH)

$(eval $(meson-package))
$(eval $(host-meson-package))
