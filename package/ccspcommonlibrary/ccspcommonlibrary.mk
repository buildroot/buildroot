################################################################################
#
# ccspcommonlibrary
#
################################################################################

CCSPCOMMONLIBRARY_VERSION = a3117b5c45532a24507557886910cdaa9d0c411c
CCSPCOMMONLIBRARY_SITE_METHOD = git
CCSPCOMMONLIBRARY_SITE = https://github.com/rdkcmf/rdkb-CcspCommonLibrary.git
CCSPCOMMONLIBRARY_INSTALL_STAGING = YES
CCSPCOMMONLIBRARY_AUTORECONF = YES
CCSPCOMMONLIBRARY_DEPENDENCIES = dbus

define CCSPCOMMONLIBRARY_FIXUP_M4_DIR
        mkdir $(@D)/m4
endef
CCSPCOMMONLIBRARY_POST_EXTRACT_HOOKS += CCSPCOMMONLIBRARY_FIXUP_M4_DIR

CCSPCOMMONLIBRARY_CONF_OPTS = \
    --prefix=/usr/ \
    --includedir=${STAGING_DIR}/usr/include \
    --libdir=${STAGING_DIR}/usr/lib \
    --bindir=${STAGING_DIR}/usr/bin \
    --docdir=${STAGING_DIR}/usr/share/doc \
    ${CUSTOM_HOST}

CCSPCOMMONLIBRARY_CONF_ENV += CPPFLAGS="$(TARGET_CXXFLAGS) -I${STAGING_DIR}/usr/include/dbus-1.0 -I${STAGING_DIR}/usr/lib/dbus-1.0/include"


define CCSPCOMMONLIBRARY_INSTALL_STAGING_CMDS
    cp -ar $(@D)/.libs/libccsp_common.so* $(STAGING_DIR)/usr/lib
    mkdir -p ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/debug_api/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/util_api/ansc/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/util_api/asn.1/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/util_api/http/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/util_api/stun/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/util_api/tls/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/util_api/web/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/cosa/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/cosa/package/slap/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/cosa/package/system/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/custom/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/components/include/* ${STAGING_DIR}/usr/include/ccsp
    cp -ar $(@D)/source/ccsp/components/common/MessageBusHelper/include/* ${STAGING_DIR}/usr/include/ccsp
    cp $(@D)/source/util_api/slap/components/SlapVarConverter/slap_vco_global.h ${STAGING_DIR}/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_exported_api.h ${STAGING_DIR}/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_global.h ${STAGING_DIR}/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_interface.h ${STAGING_DIR}/usr/include/ccsp
    cp $(@D)/source/ccsp/components/common/PoamIrepFolder/poam_irepfo_internal_api.h ${STAGING_DIR}/usr/include/ccsp
endef

define CCSPCOMMONLIBRARY_INSTALL_TARGET_CMDS
    cp -ar $(@D)/.libs/libccsp_common.so* $(TARGET_DIR)/usr/lib
    mkdir -p ${TARGET_DIR}/usr/share/ccspcommonlibrary
    cp $(@D)/config/ccsp_msg.cfg ${TARGET_DIR}/usr/share/ccspcommonlibrary
endef
$(eval $(autotools-package))
