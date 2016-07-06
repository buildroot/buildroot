################################################################################
#
# gst1-common
#
################################################################################

GST1_COMMON_VERSION = ac2f647695e7bd4b433ea108ee1d0e23901797d4
GST1_COMMON_SOURCE = common-$(GST1_COMMON_VERSION).tar.xz
GST1_COMMON_SITE = http://cgit.freedesktop.org/gstreamer/common/snapshot
BR_NO_CHECK_HASH_FOR += $(GST1_COMMON_SOURCE)

define GSTREAMER1_COMMON_EXTRACT
	mkdir -p $(@D)/common
	$(INFLATE.xz) $(DL_DIR)/$(GST1_COMMON_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/common $(TAR_OPTIONS) -
	mkdir -p $(@D)/m4
	touch $(@D)/ABOUT-NLS
	touch $(@D)/config.rpath
endef

define GSTREAMER1_FIX_AUTOPOINT
	cd $(@D) && $(HOST_DIR)/usr/bin/autopoint --force
endef

define GSTREAMER1_RUN_AUTORECONF
	cd $(@D) && $(HOST_DIR)/usr/bin/autoreconf --force --install
endef

define GSTREAMER1_REMOVE_LA_FILES
	rm -f $(TARGET_DIR)/usr/lib/libgst*.la $(TARGET_DIR)/usr/lib/gstreamer-1.0/*.la
	rm -f $(TARGET_DIR)/usr/lib/libgst*.a $(TARGET_DIR)/usr/lib/gstreamer-1.0/*.a
endef

$(eval $(generic-package))
