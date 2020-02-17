################################################################################
#
# openjpeg
#
################################################################################

OPENJPEG_VER_MAJOR = 2
OPENJPEG_VER_MINOR = 1
OPENJPEG_VER_PATCH = 2
OPENJPEG_VERSION = $(OPENJPEG_VER_MAJOR).$(OPENJPEG_VER_MINOR).$(OPENJPEG_VER_PATCH)
OPENJPEG_SITE = $(call github,uclouvain,openjpeg,v$(OPENJPEG_VERSION))
OPENJPEG_LICENSE = BSD-2c
OPENJPEG_LICENSE_FILES = LICENSE
OPENJPEG_INSTALL_STAGING = YES

OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_ZLIB),zlib)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LIBPNG),libpng)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_TIFF),tiff)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LCMS2),lcms2)

# This is done here only because NF 5.2.2 expects this to be in openjpeg-$(VERSION_MAJOR)
# (where by default it lands in openjpeg-$(VERSION_MAJOR).$(VERSION_MINOR))
define OPENJPEG_MAKE_LINK_FOR_NF
	ln -s $(STAGING_DIR)/usr/include/openjpeg-$(OPENJPEG_VER_MAJOR).$(OPENJPEG_VER_MINOR)  $(STAGING_DIR)/usr/include/openjpeg-$(OPENJPEG_VER_MAJOR)
endef

OPENJPEG_POST_INSTALL_STAGING_HOOKS += OPENJPEG_MAKE_LINK_FOR_NF

$(eval $(cmake-package))
