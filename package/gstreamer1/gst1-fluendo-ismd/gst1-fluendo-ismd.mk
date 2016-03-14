################################################################################
#
# gst1-fluendo-ismd
#
################################################################################

GST1_FLUENDO_ISMD_VERSION = 1d6cdfa2dc0689494fb543fb1abafe7726018ec1
GST1_FLUENDO_ISMD_SITE_METHOD = git
GST1_FLUENDO_ISMD_SITE = git@github.com:Metrological/gst-fluendo-ismd.git

GST1_FLUENDO_ISMD_LICENSE = LGPLv2.1
GST1_FLUENDO_ISMD_LICENSE_FILES = COPYING

GST1_FLUENDO_ISMD_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES

GST1_FLUENDO_ISMD_DEPENDENCIES = \
    gstreamer1 \
    gst1-plugins-base \
    intelce-audio \
    intelce-bufmon \
    intelce-clock \
    intelce-clock_recovery \
    intelce-core \
    intelce-demux \
    intelce-display \
    intelce-mux \
    intelce-system_utils \
    intelce-viddec \
    intelce-videnc \
    intelce-vidpproc \
    intelce-vidrend \
    intelce-vidsink \
    zlib \

GST1_FLUENDO_ISMD_AUTORECONF = YES

GST1_FLUENDO_ISMD_MAKE_OPTS += -I${STAGING_DIR}/usr/include/ -I${STAGING_DIR}/include/

GST1_FLUENDO_ISMD_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-I$(STAGING_DIR)/include \
		-I$(STAGING_DIR)/include/linux_user \
		-I${STAGING_DIR}/usr/include/"

GST1_FLUENDO_ISMD_CONF_OPTS = --disable-valgrind --disable-transcode --disable-examples

$(eval $(autotools-package))
