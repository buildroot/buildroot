################################################################################
#
# libmad
#
################################################################################

LIBMAD_VERSION = 0.15.1b
LIBMAD_SOURCE = libmad_$(LIBMAD_VERSION).orig.tar.gz
LIBMAD_SITE = \
	http://snapshot.debian.org/archive/debian/20190310T213528Z/pool/main/libm/libmad
LIBMAD_INSTALL_STAGING = YES
LIBMAD_LICENSE = GPL-2.0+
LIBMAD_LICENSE_FILES = COPYING

# Force autoreconf to be able to use a more recent libtool script, that
# is able to properly behave in the face of a missing C++ compiler.
LIBMAD_AUTORECONF = YES

# libmad has some assembly function that is not present in Thumb mode:
# Error: selected processor does not support `smull r6,r7,r3,r1' in Thumb mode
# so, we deactivate Thumb mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
LIBMAD_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -marm"
endif

define LIBMAD_INSTALL_STAGING_PC
	$(INSTALL) -D package/libmad/mad.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/mad.pc
endef

LIBMAD_POST_INSTALL_STAGING_HOOKS += LIBMAD_INSTALL_STAGING_PC

LIBMAD_CONF_OPTS = \
	--disable-debugging \
	$(if $(BR2_PACKAGE_LIBMAD_OPTIMIZATION_SPEED),--enable-speed) \
	$(if $(BR2_PACKAGE_LIBMAD_OPTIMIZATION_ACCURACY),--enable-accuracy) \
	--$(if $(BR2_PACKAGE_LIBMAD_SSO),enable,disable)-sso \
	--$(if $(BR2_PACKAGE_LIBMAD_ASO),enable,disable)-aso \
	--$(if $(BR2_PACKAGE_LIBMAD_STRICT_ISO),enable,disable)-strict-iso

$(eval $(autotools-package))
