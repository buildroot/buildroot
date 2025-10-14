################################################################################
#
# gstd
#
################################################################################

GSTD_VERSION = 0.15.2
GSTD_SITE = $(call github,RidgeRun,gstd-1.x,v$(GSTD_VERSION))
GSTD_LICENSE_FILES = COPYING
GSTD_LICENSE = LGPL-2.1+

GSTD_DEPENDENCIES = \
	$(BR2_COREUTILS_HOST_DEPENDENCY) \
	gstreamer1 \
	jansson \
	json-glib \
	libdaemon \
	libedit \
	libglib2 \
	libsoup

GSTD_CONF_OPTS = \
	-Denable-tests=disabled \
	-Denable-examples=disabled \
	-Denable-gtk-doc=false \
	-Denable-python=disabled \
	-Dwith-gstd-runstatedir=/var/run/gstd \
	-Dwith-gstd-logstatedir=/var/log/gstd \
	-Dwith-gstd-systemddir=/usr/lib/systemd/system

GSTD_CFLAGS = $(TARGET_CFLAGS) -std=gnu99

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
GSTD_CONF_OPTS += -Denable-systemd=enabled -Denable-initd=disabled
GSTD_DEPENDENCIES += systemd
else
GSTD_CONF_OPTS += -Denable-systemd=disabled -Denable-initd=enabled
endif

$(eval $(meson-package))
