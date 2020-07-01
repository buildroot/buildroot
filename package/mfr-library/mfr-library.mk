###############################################################################
#
# MFRLibrary
#
################################################################################

MFR_LIBRARY_VERSION = 01ede7a48f6d296b5a4b7c592e60da718cef4cbf
MFR_LIBRARY_SITE = git@github.com:Metrological/MFRLibrary.git
MFR_LIBRARY_SITE_METHOD = git
MFR_LIBRARY_INSTALL_STAGING = YES


define MFR_LIBRARY_POST_STAGING_INSTALL_PKGCONFIG
    $(INSTALL) -d ${STAGING_DIR}/usr/lib/pkgconfig
    $(INSTALL) -D package/mfr-library/fwupgrade.pc ${STAGING_DIR}/usr/lib/pkgconfig/fwupgrade.pc
endef

define MFR_LIBRARY_POST_TARGET_REMOVE_HEADERS
    rm -rf $(TARGET_DIR)/usr/include/mfrlib
endef

MFR_LIBRARY_POST_INSTALL_TARGET_HOOKS += MFR_LIBRARY_POST_TARGET_REMOVE_HEADERS
MFR_LIBRARY_POST_INSTALL_STAGING_HOOKS += MFR_LIBRARY_POST_STAGING_INSTALL_PKGCONFIG

$(eval $(cmake-package))
