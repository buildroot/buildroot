################################################################################
#
# ccspcommonlibrary
#
################################################################################

CCSPCOMMONLIBRARY_VERSION = 6432e257aa30bdf766db16a0db83394801bc4708
CCSPCOMMONLIBRARY_SITE_METHOD = git
CCSPCOMMONLIBRARY_SITE = https://github.com/rdkcmf/rdkb-CcspCommonLibrary.git
CCSPCOMMONLIBRARY_INSTALL_STAGING = YES
CCSPCOMMONLIBRARY_AUTORECONF = YES
CCSPCOMMONLIBRARY_DEPENDENCIES = dbus safeclib rbus

define CCSPCOMMONLIBRARY_FIXUP_M4_DIR
        mkdir $(@D)/m4
endef
CCSPCOMMONLIBRARY_POST_EXTRACT_HOOKS += CCSPCOMMONLIBRARY_FIXUP_M4_DIR

CCSPCOMMONLIBRARY_CONF_OPTS = \
    --prefix=/usr/ \
    --includedir=$(STAGING_DIR)/usr/include \
    --libdir=$(STAGING_DIR)/usr/lib \
    --bindir=$(STAGING_DIR)/usr/bin \
    --docdir=$(STAGING_DIR)/usr/share/doc \
    --with-ccsp-platform=bcm \
    --with-ccsp-arch=arm \
    $(CUSTOM_HOST)

CCSPCOMMONLIBRARY_CPPFLAGS = $(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/dbus-1.0 -I$(STAGING_DIR)/usr/lib/dbus-1.0/include -I$(STAGING_DIR)/usr/include/libsafec -I$(STAGING_DIR)/usr/include/rtmessage -I$(STAGING_DIR)/usr/include/rbus -D_DEBUG

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
#    -U_COSA_SIM_ -fno-exceptions -ffunction-sections -fdata-sections -fomit-frame-pointer -fno-strict-aliasing \
    -D_ANSC_LINUX -D_ANSC_USER -D_ANSC_LITTLE_ENDIAN_ -D_CCSP_CWMP_TCP_CONNREQ_HANDLER \
    -D_DSLH_STUN_ -D_NO_PKI_KB5_SUPPORT -D_BBHM_SSE_FILE_IO -D_ANSC_USE_OPENSSL_ -DENABLE_SA_KEY \
    -D_ANSC_AES_USED_ -D_COSA_INTEL_USG_ARM_ -D_COSA_FOR_COMCAST_ -D_NO_EXECINFO_H_ -DFEATURE_SUPPORT_SYSLOG \
    -DBUILD_WEB -D_NO_ANSC_ZLIB_ -D_DEBUG -U_ANSC_IPV6_COMPATIBLE_ -D_COSA_BCM_ARM_ -DUSE_NOTIFY_COMPONENT \
    -D_PLATFORM_RASPBERRYPI_ -DENABLE_SD_NOTIFY -DCOSA_DML_WIFI_FEATURE_LoadPsmDefaults -UPARODUS_ENABLE \
    -DCONFIG_VENDOR_CUSTOMER_COMCAST
CCSPCOMMONLIBRARY_CPPFLAGS += -D_ANSC_LINUX -D_ANSC_USE_OPENSSL_ -D_NO_PKI_KB5_SUPPORT
endif

CCSPCOMMONLIBRARY_CONF_ENV += CPPFLAGS="$(CCSPCOMMONLIBRARY_CPPFLAGS)"
CCSPCOMMONLIBRARY_CONF_ENV += LIBS=`pkg-config --libs dbus-1`
CCSPCOMMONLIBRARY_CONF_ENV += LIBS=`pkg-config --libs libsafec`

define CCSPCOMMONLIBRARY_INSTALL_PACKAGE
    cp -ar $(@D)/source/.libs/libccsp_common.so* $(1)/usr/lib
endef

define CCSPCOMMONLIBRARY_INSTALL_STAGING_CMDS
    $(call CCSPCOMMONLIBRARY_INSTALL_PACKAGE,$(STAGING_DIR))
    mkdir -p $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/debug_api/include/*.h $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/util_api/ansc/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/util_api/asn.1/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/util_api/http/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/util_api/stun/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/util_api/tls/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/util_api/web/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/cosa/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/cosa/include/linux/*.h $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/cosa/package/slap/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/cosa/package/system/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/custom/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/components/include/* $(STAGING_DIR)/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/components/common/MessageBusHelper/include/* $(STAGING_DIR)/usr/include/ccsp
    cp $(@D)/source/util_api/slap/components/SlapVarConverter/slap_vco_global.h $(STAGING_DIR)/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_exported_api.h $(STAGING_DIR)/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_global.h $(STAGING_DIR)/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_interface.h $(STAGING_DIR)/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_internal_api.h $(STAGING_DIR)/usr/include/ccsp
endef

define CCSPCOMMONLIBRARY_INSTALL_TARGET_CMDS
    $(call CCSPCOMMONLIBRARY_INSTALL_PACKAGE,$(TARGET_DIR))
    mkdir -p $(TARGET_DIR)/usr/ccsp
    cp $(@D)/config/ccsp_msg.cfg $(TARGET_DIR)/usr/ccsp
endef
$(eval $(autotools-package))
