################################################################################
#
# vgdrm
#
################################################################################
VGDRM_VERSION = 248e0d83b3c96adc6b2a530d96c2b9cc73035de1
VGDRM_SITE = git@github.com:Metrological/vgdrm.git
VGDRM_SITE_METHOD = git
VGDRM_LICENSE = PROPRIETARY
VGDRM_INSTALL_STAGING = YES
VGDRM_INSTALL_TARGET = YES

define VGDRM_BUILD_CMDS
endef

define VGDRM_INSTALL_STAGING_CMDS
    cp -av ${@D}/usr ${STAGING_DIR}
    cp -av ${@D}/etc ${STAGING_DIR}
endef

define VGDRM_INSTALL_TARGET_CMDS
    cp -av ${@D}/usr/lib/lib*.so* ${STAGING_DIR}/usr/lib
    cp -av ${@D}/etc ${TARGET_DIR}
endef

$(eval $(generic-package))
