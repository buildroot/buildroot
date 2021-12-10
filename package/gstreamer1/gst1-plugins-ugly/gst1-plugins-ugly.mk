################################################################################
#
# gst1-plugins-ugly
#
################################################################################

GST1_PLUGINS_UGLY_VERSION = 1.16.2
GST1_PLUGINS_UGLY_SOURCE = gst-plugins-ugly-$(GST1_PLUGINS_UGLY_VERSION).tar.xz
GST1_PLUGINS_UGLY_SITE = https://gstreamer.freedesktop.org/src/gst-plugins-ugly
GST1_PLUGINS_UGLY_LICENSE_FILES = COPYING
# GPL licensed plugins will append to GST1_PLUGINS_UGLY_LICENSE if enabled.
GST1_PLUGINS_UGLY_LICENSE = LGPL-2.1+

ifeq ($(BR2_PACKAGE_GSTREAMER1_GIT),y)
GST1_PLUGINS_UGLY_SOURCE = gst-plugins-ugly-$(GST1_PLUGINS_UGLY_VERSION).tar.bz2
GST1_PLUGINS_UGLY_SITE = "https://gitlab.freedesktop.org/gstreamer/gst-plugins-ugly/-/archive/$(GST1_PLUGINS_UGLY_VERSION)/"
BR_NO_CHECK_HASH_FOR += $(GST1_PLUGINS_UGLY_SOURCE)
GST1_PLUGINS_UGLY_AUTORECONF = YES
GST1_PLUGINS_UGLY_AUTORECONF_OPTS = -I $(@D)/common/m4
GST1_PLUGINS_UGLY_GETTEXTIZE = YES
GST1_PLUGINS_UGLY_POST_DOWNLOAD_HOOKS += GSTREAMER1_COMMON_DOWNLOAD
GST1_PLUGINS_UGLY_POST_EXTRACT_HOOKS += GSTREAMER1_COMMON_EXTRACT
GST1_PLUGINS_UGLY_PRE_CONFIGURE_HOOKS += GSTREAMER1_FIX_AUTOPOINT
GST1_PLUGINS_UGLY_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES
endif

GST1_PLUGINS_UGLY_CFLAGS = $(TARGET_CFLAGS) $(GSTREAMER1_EXTRA_COMPILER_OPTIONS)
GST1_PLUGINS_UGLY_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

GST1_PLUGINS_UGLY_CONF_OPTS += \
	-Dexamples=disabled \
	-Dtests=disabled

GST1_PLUGINS_UGLY_CONF_OPTS += \
	-Da52dec=disabled \
	-Damrnb=disabled \
	-Damrwbdec=disabled \
	-Dcdio=disabled \
	-Dsidplay=disabled

GST1_PLUGINS_UGLY_DEPENDENCIES = gstreamer1 gst1-plugins-base

ifeq ($(BR2_PACKAGE_ORC),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Dorc=enabled
GST1_PLUGINS_UGLY_DEPENDENCIES += orc
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Dorc=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_ASFDEMUX),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Dasfdemux=enabled
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Dasfdemux=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_DVDLPCMDEC),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Ddvdlpcmdec=enabled
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Ddvdlpcmdec=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_DVDSUB),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Ddvdsub=enabled
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Ddvdsub=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_XINGMUX),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Dxingmux=enabled
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Dxingmux=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_REALMEDIA),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Drealmedia=enabled
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Drealmedia=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_DVDREAD),y)
# configure does not use pkg-config to detect libdvdread
ifeq ($(BR2_PACKAGE_LIBDVDCSS)$(BR2_STATIC_LIBS),yy)
GST1_PLUGINS_UGLY_LDFLAGS += "-ldvdcss"
endif
GST1_PLUGINS_UGLY_CONF_OPTS += -Ddvdread=enabled
GST1_PLUGINS_UGLY_DEPENDENCIES += libdvdread
GST1_PLUGINS_UGLY_HAS_GPL_LICENSE = y
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Ddvdread=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_MPEG2DEC),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Dmpeg2dec=enabled
GST1_PLUGINS_UGLY_DEPENDENCIES += libmpeg2
GST1_PLUGINS_UGLY_HAS_GPL_LICENSE = y
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Dmpeg2dec=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_X264),y)
GST1_PLUGINS_UGLY_CONF_OPTS += -Dx264=enabled
GST1_PLUGINS_UGLY_DEPENDENCIES += x264
GST1_PLUGINS_UGLY_HAS_GPL_LICENSE = y
else
GST1_PLUGINS_UGLY_CONF_OPTS += -Dx264=disabled
endif

# Add GPL license if GPL plugins enabled.
ifeq ($(GST1_PLUGINS_UGLY_HAS_GPL_LICENSE),y)
GST1_PLUGINS_UGLY_LICENSE += GPL-2.0
endif

# Use the following command to extract license info for plugins.
# # find . -name 'plugin-*.xml' | xargs grep license

$(eval $(meson-package))
