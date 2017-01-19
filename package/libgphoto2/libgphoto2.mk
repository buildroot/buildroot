#############################################################
#
# libgphoto2
#
#############################################################
LIBGPHOTO2_VERSION= libgphoto2-2_5_11-release
LIBGPHOTO2_SITE_METHOD = git
LIBGPHOTO2_SITE = git@github.com:gphoto/libgphoto2.git
LIBGPHOTO2_INSTALL_STAGING = YES
LIBGPHOTO2_INSTALL_TARGET = YES
LIBGPHOTO2_LICENSE_FILES = COPYING
LIBGPHOTO2_LICENSE = LGPLv2+, LGPLv2.1+
LIBGPHOTO2_DEPENDENCIES = libtool libusb libexif gettext libxml2

LIBGPHOTO2_DEPENDENCIES_PARANOID_UNSAFE_PATH = BR2_COMPILER_PARANOID_UNSAFE_PATH

LIBGPHOTO2_PRE_CONFIGURE_HOOKS += LIBGPHOTO2_RUN_AUTORECONF
LIBGPHOTO2_POST_INSTALL_TARGET_HOOKS += LIBGPHOTO2_REMOVE_LA_FILES 

define LIBGPHOTO2_RUN_AUTORECONF
	cd $(@D) && $(HOST_DIR)/usr/bin/autoreconf --install --symlink
endef

define LIBGPHOTO2_REMOVE_LA_FILES
	rm -f $(TARGET_DIR)/usr/lib/libgphoto2*.la $(TARGET_DIR)/usr/lib/libgphoto2/*/*.la
	rm -f $(TARGET_DIR)/usr/lib/libgphoto2*.a $(TARGET_DIR)/usr/lib/libgphoto2/*/*.a
endef

$(eval $(autotools-package))
