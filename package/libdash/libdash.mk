################################################################################
#
# libdash
#
################################################################################

LIBDASH_VERSION = f5b5d991af5fe5f285e8040c997b755d3d456b0d
LIBDASH_SITE_METHOD = git
LIBDASH_SITE = https://github.com/bitmovin/libdash
LIBDASH_INSTALL_STAGING = YES

LIBDASH_DEPENDENCIES = libcurl libxml2 zlib

define LIBDASH_EXTRACT_DASH
    mv $(@D)/libdash $(@D)/temp
    mv $(@D)/temp/* $(@D)
    rm -rf $(@D)/temp
endef

LIBDASH_POST_EXTRACT_HOOKS += LIBDASH_EXTRACT_DASH

define LIBDASH_INSTALL_STAGING_CMDS
   $(INSTALL) -D -m 0755 ${LIBDASH_PKGDIR}/libdash.pc $(STAGING_DIR)/usr/lib/pkgconfig/
   mkdir -p $(STAGING_DIR)/usr/include/libdash 
   mkdir -p $(STAGING_DIR)/usr/include/libdash/helpers
   mkdir -p $(STAGING_DIR)/usr/include/libdash/mpd
   mkdir -p $(STAGING_DIR)/usr/include/libdash/network
   mkdir -p $(STAGING_DIR)/usr/include/libdash/portable
   mkdir -p $(STAGING_DIR)/usr/include/libdash/metrics
   mkdir -p $(STAGING_DIR)/usr/include/libdash/xml
   $(INSTALL) -D -m 0755 $(@D)/libdash/include/*.h $(STAGING_DIR)/usr/include/libdash/
   $(INSTALL) -D -m 0755 $(@D)/libdash/source/helpers/*.h $(STAGING_DIR)/usr/include/libdash/helpers/
   $(INSTALL) -D -m 0755 $(@D)/libdash/source/mpd/*.h $(STAGING_DIR)/usr/include/libdash/mpd/
   $(INSTALL) -D -m 0755 $(@D)/libdash/source/network/*.h $(STAGING_DIR)/usr/include/libdash/network/
   $(INSTALL) -D -m 0755 $(@D)/libdash/source/portable/*.h $(STAGING_DIR)/usr/include/libdash/portable/
   $(INSTALL) -D -m 0755 $(@D)/libdash/source/metrics/*.h $(STAGING_DIR)/usr/include/libdash/metrics/
   $(INSTALL) -D -m 0755 $(@D)/libdash/source/xml/*.h $(STAGING_DIR)/usr/include/libdash/xml/
   $(INSTALL) -D -m 0755 $(@D)/bin/libdash.so $(STAGING_DIR)/usr/lib/
endef

$(eval $(cmake-package))
