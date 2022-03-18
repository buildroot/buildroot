################################################################################
#
# gst1-bcm
#
################################################################################

ifneq ($(filter y,$(BR2_PACKAGE_GST1_BCM_UNIFIED_VERSION)),)
GST1_BCM_SITE = git@github.com:Metrological/bcm-collaboration
GST1_BCM_VERSION = 479464d4205d3f8828ca06609ff9b9ec89bd7b13
else
GST1_BCM_SITE = git@github.com:Metrological/gstreamer-plugins-soc.git

ifeq ($(BR2_PACKAGE_UMA_SDK),y)
GST1_BCM_VERSION = 17.1-7
else ifeq ($(BR2_PACKAGE_BCM_REFSW_16_1),y)
GST1_BCM_VERSION = 16.1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_16_2),y)
GST1_BCM_VERSION = 16.2
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_4),y)
GST1_BCM_VERSION = 17.4-rdkv-20180503
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_1),y)
GST1_BCM_VERSION = 17.1-7
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_1_RDK),y)
GST1_BCM_VERSION = 17.1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_3_RDK),y)
GST1_BCM_VERSION = 17.3-rdkv-20180327
else ifeq ($(BR2_PACKAGE_BCM_REFSW_18_2),y)
GST1_BCM_VERSION = 18.2-rdkv-20180727
else ifeq ($(BR2_PACKAGE_BCM_REFSW_19_1),y)
GST1_BCM_VERSION = 19.1-rdkv_20190409
else ifneq ($(filter y,$(BR2_PACKAGE_ACN_SDK)),)
GST1_BCM_VERSION = 17.1-5
else ifneq ($(filter y,$(BR2_PACKAGE_HOMECAST_SDK)),)
GST1_BCM_VERSION = 961a36dcd30c91330b8a9503e12ec3ddb30b70b6
else ifneq ($(filter y,$(BR2_PACKAGE_VSS_SDK)),)
GST1_BCM_VERSION = 1b4dd52399826525be861b2add1b6471de01c060
else ifneq ($(filter y,$(BR2_PACKAGE_EVASION_SDK)),)
GST1_BCM_VERSION = 18.2-rdkv-20180727
else ifneq ($(filter y,$(BR2_PACKAGE_VFTV_SDK)),)
GST1_BCM_VERSION = 18.2-rdkv-20180727
else
GST1_BCM_VERSION = 15.2
endif

endif

GST1_BCM_SITE_METHOD = git
GST1_BCM_LICENSE = PROPRIETARY
GST1_BCM_INSTALL_STAGING = YES
GST1_BCM_DEPENDENCIES = gstreamer1 gst1-plugins-base

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
GST1_BCM_DEPENDENCIES += bcm-refsw
else
BCM_REFSW_MAKE_ENV = \
	REFSW_DIR="refsw" \
	B_REFSW_CROSS_COMPILE=${BR2_TOOLCHAIN_EXTERNAL_PREFIX}-

NEXUS_CFLAGS=$(shell cat ${STAGING_DIR}/usr/include/refsw/platform_app.inc | grep NEXUS_CFLAGS | cut -d' ' -f3- | awk -F "-std=c89" '{print $$1 $$2}')
NEXUS_LDFLAGS=$(shell cat ${STAGING_DIR}/usr/include/refsw/platform_app.inc | grep NEXUS_LDFLAGS | cut -d' ' -f3-)
NEXUS_CLIENT_LD_LIBRARIES=$(shell cat ${STAGING_DIR}/usr/include/refsw/platform_app.inc | grep NEXUS_CLIENT_LD_LIBRARIES | cut -d' ' -f4-)

CFLAGS = $(TARGET_CFLAGS) ${NEXUS_CFLAGS}
LDFLAGS = -L${STAGING_DIR}/usr/lib $(NEXUS_LDFLAGS) $(NEXUS_CLIENT_LD_LIBRARIES)
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_VP9_SUPPORT),y)
CFLAGS += -DVP9_SUPPORT
endif

GST1_BCM_AUTORECONF = YES

GST1_BCM_CONF_ENV += \
	$(BCM_REFSW_MAKE_ENV) \
	GSTREAMER_REFSW_SERVER_NXCLIENT_SUPPORT=y \
	PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)

ifeq ($(BR2_PACKAGE_GST1_BCM_ENABLE_SVP),y)
GST1_BCM_CONF_ENV += GST_SVP_SUPPORT=y
ifeq ($(BR2_PACKAGE_GST1_BCM_ENABLE_SVP_SECBUF),y)
GST1_BCM_CONF_ENV += GST_SVP_SECBUF_SUPPORT=y
endif
endif

GST1_BCM_MAKE_ENV += \
	$(BCM_REFSW_MAKE_ENV) \
	PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)

GST1_BCM_MAKE_OPTS += "\
	CFLAGS+=${CFLAGS} \
		-std=c99 \
		-I${BCM_REWSW_BIN}/include \
		-I${BCM_REFSW_DIR}/BSEAV/api/include \
		-I${BCM_REFSW_DIR}/BSEAV/lib/media/ \
		-I${STAGING_DIR}/usr/include/refsw/" \
		"LDFLAGS+=${LDFLAGS}"

GST1_BCM_CONF_OPTS = \
	--enable-gstreamer1  \
	--enable-shared \
	--with-pic \
	--disable-static \
	--enable-systemclock \
	--disable-avi \
	--disable-flv \
	--disable-httpsrc \
	--disable-ivfparse \
	--disable-matroska \
	--disable-mp3swdecode \
	--disable-mp4demux \
	--enable-pcmsink \
	--disable-pesfilter \
	--disable-pessink \
	--disable-pesdemux \
	--disable-playback \
	--disable-qtdemux \
	--disable-transcode \
	--disable-tsdemux \
	--disable-tsparse \
	--disable-playersinkbin \
	--disable-gfxsink

ifeq ($(BR2_PACKAGE_GST1_BCM_ENABLE_SVP),y)
GST1_BCM_CONF_OPTS += --enable-svp
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_AUDFILTER),y)
GST1_BCM_CONF_OPTS += --enable-audfilter
else
GST1_BCM_CONF_OPTS += --disable-audfilter
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_AUDIODECODE),y)
GST1_BCM_CONF_OPTS += --enable-audiodecode
else
GST1_BCM_CONF_OPTS += --disable-audiodecode
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_AUDIOSINK),y)
GST1_BCM_CONF_OPTS += --enable-audiosink
else
GST1_BCM_CONF_OPTS += --disable-audiosink
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_VIDEODECODE),y)
GST1_BCM_CONF_OPTS += --enable-videodecode
else
GST1_BCM_CONF_OPTS += --disable-videodecode
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_VIDEOSINK),y)
GST1_BCM_CONF_OPTS += --enable-videosink
else
GST1_BCM_CONF_OPTS += --disable-videosink
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_VIDFILTER),y)
GST1_BCM_CONF_OPTS += --enable-vidfilter
else
GST1_BCM_CONF_OPTS += --disable-vidfilter
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_ENABLE_SVP),y)
GST1_BCM_CONF_OPTS += --enable-svp
ifeq ($(BR2_PACKAGE_GST1_BCM_ENABLE_SVP_SECBUF),y)
GST1_BCM_CONF_OPTS += --enable-svp-secbuf
endif
endif

ifeq ($(BR2_PACKAGE_HAS_OPUS_DECODER),)
GST1_BCM_PKGDIR = "$(TOP_DIR)/package/gstreamer1/gst1-bcm"

define GST1_BCM_INSTALL_SVP_DEV
    if [ -d "${@D}/reference" ] ; then \
    	$(INSTALL) -D -m 0644 ${@D}/reference/svpmeta/src/gst_brcm_svp_meta.h $(STAGING_DIR)/usr/include ; \
    else \
    	$(INSTALL) -D -m 0644 ${@D}/svpmeta/src/gst_brcm_svp_meta.h $(STAGING_DIR)/usr/include ; \
    fi 
endef

GST1_BCM_POST_INSTALL_STAGING_HOOKS += GST1_BCM_INSTALL_SVP_DEV
endif

ifeq ($(BR2_PACKAGE_VSS_SDK_MOVE_GSTREAMER),y)
# this platform needs to run this gstreamer version parallel
# to an older version.
GST1_BCM_CONF_OPTS += \
	--datadir=/usr/share/gstreamer-wpe \
	--datarootdir=/usr/share/gstreamer-wpe \
	--sysconfdir=/etc/gstreamer-wpe \
	--includedir=/usr/include/gstreamer-wpe \
	--program-prefix wpe
define GST1_BCM_APPLY_VSS_FIX
 package/vss-sdk/gst1/brcm.fix.sh ${@D}
endef
GST1_BCM_PRE_CONFIGURE_HOOKS += GST1_BCM_APPLY_VSS_FIX
endif

ifeq ($(BR2_PACKAGE_GST1_BCM_CREATE_BINARY_ML_DELIVERY),y)
ML_DELIVERY_GST1_BCM_SIGNATURE=${GST1_BCM_VERSION}
ML_DELIVERY_GST1_BCM_PACKAGE=${GST1_BCM_NAME}
ML_DELIVERY_GST1_BCM_DIR=${STAGING_DIR}/${ML_DELIVERY_GST1_BCM_PACKAGE}
ML_DELIVERY_GST1_BCM_TARBALL=${BINARIES_DIR}/${ML_DELIVERY_GST1_BCM_PACKAGE}-${ML_DELIVERY_GST1_BCM_SIGNATURE}.tar.xz

define CREATE_BINARY_ML_DELIVERY_GST1_BCM
	rm -rf ${ML_DELIVERY_GST1_BCM_DIR} ${ML_DELIVERY_GST1_BCM_TARBALL}
	mkdir -p ${ML_DELIVERY_GST1_BCM_DIR}
 	$(GST1_BCM_MAKE_ENV) $(MAKE) DESTDIR=${ML_DELIVERY_GST1_BCM_DIR} install -C ${@D}
	ln -s gstreamer-wpe/gst_brcm_svp_meta.h ${ML_DELIVERY_GST1_BCM_DIR}/usr/include/gst_brcm_svp_meta.h
	tar -cJf ${ML_DELIVERY_GST1_BCM_TARBALL} -C ${STAGING_DIR} ${ML_DELIVERY_GST1_BCM_PACKAGE}
endef

GST1_BCM_POST_INSTALL_TARGET_HOOKS += CREATE_BINARY_ML_DELIVERY_GST1_BCM
endif

$(eval $(autotools-package))
