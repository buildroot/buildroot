################################################################################
#
# lv2
#
################################################################################

LV2_VERSION = 1.18.10
LV2_SITE = https://lv2plug.in/spec
LV2_SOURCE = lv2-$(LV2_VERSION).tar.xz
LV2_LICENSE = ISC
LV2_LICENSE_FILES = COPYING
LV2_DEPENDENCIES = host-pkgconf
LV2_INSTALL_STAGING = YES

LV2_CONF_OPTS += \
	-Ddocs=disabled \
	-Dtests=disabled

ifeq ($(BR2_PACKAGE_CAIRO),y)
LV2_DEPENDENCIES += cairo
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
LV2_DEPENDENCIES += libsndfile
endif

ifeq ($(BR2_PACKAGE_LIBGTK2),y)
LV2_DEPENDENCIES += libgtk2
endif

ifeq ($(BR2_STATIC_LIBS),y)
LV2_CONF_OPTS += -Dplugins=disabled
endif

$(eval $(meson-package))
