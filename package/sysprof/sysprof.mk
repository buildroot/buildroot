################################################################################
#
# sysprof
#
################################################################################

SYSPROF_VERSION_MAJOR = 47
SYSPROF_VERSION = $(SYSPROF_VERSION_MAJOR).2
SYSPROF_SOURCE = sysprof-$(SYSPROF_VERSION).tar.xz
SYSPROF_SITE = https://download.gnome.org/sources/sysprof/$(SYSPROF_VERSION_MAJOR)
SYSPROF_LICENSE = GPL-3.0+
SYSPROF_LICENSE_FILES = COPYING
SYSPROF_DEPENDENCIES = libglib2 libdex libunwind json-glib polkit
SYSPROF_CONF_OPTS = \
	-Ddevelopment=false \
	-Dexamples=false \
	-Dgtk=false \
	-Dhelp=false \
	-Dinstall-static=false \
	-Dlibsysprof=true \
	-Dtests=false \
	-Dtools=true \
	-Dsystemdunitdir=/usr/lib/systemd/system

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
SYSPROF_DEPENDENCIES += systemd
endif

$(eval $(meson-package))
