################################################################################
#
# gst-omx
#
################################################################################

GST_OMX_VERSION = 1.10.4
GST_OMX_SOURCE = gst-omx-$(GST_OMX_VERSION).tar.xz
GST_OMX_SITE = https://gstreamer.freedesktop.org/src/gst-omx

ifeq ($(BR2_PACKAGE_GSTREAMER1_GIT),y)
GST_OMX_VERSION = 98df98e65b4035792557a76d21897fd953875bca
GST_OMX_SOURCE = gst-omx-$(GST_OMX_VERSION).tar.xz
GST_OMX_SITE = http://cgit.freedesktop.org/gstreamer/gst-omx/snapshot
BR_NO_CHECK_HASH_FOR += $(GST_OMX_SOURCE)
GST_OMX_POST_DOWNLOAD_HOOKS += GSTREAMER1_COMMON_DOWNLOAD
GST_OMX_POST_EXTRACT_HOOKS += GSTREAMER1_COMMON_EXTRACT
GST_OMX_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES
GST_OMX_AUTORECONF = YES
GST_OMX_AUTORECONF_OPTS = -I $(@D)/common/m4
endif

GST_OMX_LICENSE = LGPLv2.1
GST_OMX_LICENSE_FILES = COPYING

GST_OMX_DEPENDENCIES = gstreamer1 gst1-plugins-base libopenmax

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
GST_OMX_CONF_OPTS = \
	--with-omx-target=rpi
GST_OMX_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-D_VIDEOCORE -DRASPBERRY_PI \
		-I$(STAGING_DIR)/usr/include/IL \
		-I$(STAGING_DIR)/usr/include/interface/vcos/pthreads \
		-I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux \
                $(GSTREAMER1_EXTRA_COMPILER_OPTIONS)"
GST_OMX_DEPENDENCIES += gst1-plugins-bad
endif

ifeq ($(BR2_PACKAGE_BELLAGIO),y)
GST_OMX_CONF_OPTS = \
	--with-omx-target=bellagio
GST_OMX_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-DOMX_VERSION_MAJOR=1 \
		-DOMX_VERSION_MINOR=1 \
		-DOMX_VERSION_REVISION=2 \
		-DOMX_VERSION_STEP=0"
endif

GST_OMX_CONF_OPTS += \
	--disable-examples

# adjust library paths to where buildroot installs them
define GST_OMX_FIXUP_CONFIG_PATHS
	find $(@D)/config -name gstomx.conf | \
		xargs $(SED) 's|/usr/local|/usr|g' -e 's|/opt/vc|/usr|g'
endef

GST_OMX_POST_PATCH_HOOKS += GST_OMX_FIXUP_CONFIG_PATHS

$(eval $(autotools-package))
