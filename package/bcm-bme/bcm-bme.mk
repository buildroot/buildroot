################################################################################
#
# bcm-bme
#
################################################################################

BCM_BME_VERSION = 1c99b11cc71a1aefa742da1c4b7df8a2960268eb
BCM_BME_SITE = git@github.com:Metrological/bcm-bme.git
BCM_BME_SITE_METHOD = git
BCM_BME_DEPENDENCIES = gyp host-ninja
BCM_BME_LICENSE = PROPRIETARY
BCM_BME_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
GST1_BCM_DEPENDENCIES += bcm-refsw
endif

NEXUS_CFLAGS=$(shell cat ${STAGING_DIR}/usr/include/platform_app.inc | grep NEXUS_CFLAGS | cut -d' ' -f3- | awk -F "-std=c89" '{print $$1 $$2}')
NEXUS_LDFLAGS=$(shell cat ${STAGING_DIR}/usr/include/platform_app.inc | grep NEXUS_LDFLAGS | cut -d' ' -f3-)
NEXUS_CLIENT_LD_LIBRARIES=$(shell cat ${STAGING_DIR}/usr/include/platform_app.inc | grep NEXUS_CLIENT_LD_LIBRARIES | cut -d' ' -f4-)

BCM_BME_CFLAGS = $(TARGET_CFLAGS) ${NEXUS_CFLAGS} -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/refsw
BCM_BME_LDFLAGS = $(TARGET_LDFLAGS) -L${STAGING_DIR}/usr/lib $(NEXUS_LDFLAGS) $(NEXUS_CLIENT_LD_LIBRARIES) -lnxclient

BCM_BME_CFLAGS_FILTERED = $(filter-out -std=c89 -Wstrict-prototypes -pedantic, $(BCM_BME_CFLAGS))

# default to build in release
BME_BUILD_TYPE ?= Release

BME_BUILDDIR = $(@D)/build-$(BME_BUILD_TYPE)

BME_BINDIR = $(BME_BUILDDIR)/out/$(BME_BUILD_TYPE)

BME_ENABLE_DIAL=n
BME_ENABLE_TV=n

SAGE_SUPPORT=n
SAGE_LDFLAGS=""

BME_ENABLE_PLAYREADY=n
LIB_PLAYREADYPK25=playreadypk
LIB_PLAYREADYPK30=playready30pk
PLAYREADY_VERSION_32=n
PLAYREADY_VERSION_25=n

BME_ENABLE_WIDEVINE=n
WIDEVINE_LDFLAGS=""
CENC_DIR=""

BSEAV_TOP=""

CURL_CFLAGS=$(TARGET_CFLAGS)

GYP_OPTIONS = -DNEXUS_CFLAGS="$(BCM_BME_CFLAGS_FILTERED)" \
              -DNEXUS_LDFLAGS="$(BCM_BME_LDFLAGS)" \
              -DLIB_PLAYREADYPK25=\"lib$(LIB_PLAYREADYPK25).so\" \
              -DLIB_PLAYREADYPK30=\"lib$(LIB_PLAYREADYPK30).so\" \
              -DBME_ENABLE_TV="$(BME_ENABLE_TV)" \
              -DBME_ENABLE_DIAL="$(BME_ENABLE_DIAL)" \
              -DBME_ENABLE_PLAYREADY="$(BME_ENABLE_PLAYREADY)" \
              -DPLAYREADY_VERSION_25="$(PLAYREADY_VERSION_25)" \
              -DPLAYREADY_VERSION_32="$(PLAYREADY_VERSION_32)" \
              -DBME_ENABLE_WIDEVINE="$(BME_ENABLE_WIDEVINE)" \
              -DSAGE_SUPPORT="$(SAGE_SUPPORT)" \
              -DSAGE_LDFLAGS="$(SAGE_LDFLAGS)" \
              -DBME_LDFLAGS="$(BCM_BME_LDFLAGS)"\
              -DWIDEVINE_LDFLAGS="$(WIDEVINE_LDFLAGS)"\
              -DCENC_DIR="$(CENC_DIR)" \
              -DBSEAV_TOP="$(BSEAV_TOP)" \
              -DLIBCURL_CFLAGS="$(CURL_CFLAGS)" \
              -I$(@D)/build/common.gypi

GYP_GENERATORS=ninja

define BCM_BME_CONFIGURE_CMDS
	@CC="$(TARGET_CC)" \
	CXX="$(TARGET_CXX)" \
	LD="$(TARGET_LD)" \
	AR="$(TARGET_AR)" \
	AS="$(TARGET_AS)" \
	RANLIB="$(TARGET_RANLIB)" \
	CC_host="$(TARGET_CROSS)-gcc" \
	CXX_host="$(TARGET_CROSS)-g++" \
	LD_host="$(TARGET_CROSS)-g++" \
	AR_host="$(TARGET_CROSS)-ar" \
	AS_host="$(TARGET_CROSS)-as" \
	GYP_DEFINES="$(NEXUS_CFLAGS)" \
	GYP_GENERATORS="$(GYP_GENERATORS)" \
	$(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/gyp $(@D)/build/media.gyp --depth=./ --generator-output=$(BME_BUILDDIR) $(GYP_OPTIONS);
endef

define  BCM_BME_INSTALL
	$(INSTALL) -m 755 -d $(1)/usr/bin/bme/
	$(INSTALL) -m 750 -D $(BME_BINDIR)/lib/*.so $(1)/usr/lib
	$(INSTALL) -m 750 -D $(BME_BINDIR)/mediaplayer $(1)/usr/bin/bme
	$(INSTALL) -m 750 -D $(BME_BINDIR)/mosaicPlayer $(1)/usr/bin/bme
	$(INSTALL) -m 750 -D $(BME_BINDIR)/pcmPlayer $(1)/usr/bin/bme
	$(INSTALL) -m 750 -D $(BME_BINDIR)/playerTest $(1)/usr/bin/bme
	$(INSTALL) -m 750 -D $(BME_BINDIR)/texturePlayer $(1)/usr/bin/bme
	
endef

define  BCM_BME_INSTALL_PC
	$(INSTALL) -m 644 $(@D)/player/include/*.h $(STAGING_DIR)/usr/lib/pkgconfig/
	sed -e 's/%prefix%/\/usr/' -e 's/%libs%//' $(@D)/build/bme-player.pc > $(STAGING_DIR)/usr/lib/pkgconfig/bme-player.pc
endef

define  BCM_BME_INSTALL_DEV
	$(call BCM_BME_INSTALL,$(STAGING_DIR))
	$(call BCM_BME_INSTALL_PC,$(STAGING_DIR))
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/bme
	$(INSTALL) -m 644 $(@D)/player/include/*.h $(STAGING_DIR)/usr/include/bme/
endef

define BCM_BME_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/ninja -C $(BME_BINDIR)
endef

define BCM_BME_INSTALL_STAGING_CMDS
	$(call BCM_BME_INSTALL_DEV)
endef

define BCM_BME_INSTALL_TARGET_CMDS
	$(call BCM_BME_INSTALL,$(TARGET_DIR))
endef

$(eval $(generic-package))
