################################################################################
#
# libmpeg2
#
################################################################################

LIBMPEG2_VERSION = 0.5.1
# Gitlab repository does not have a 0.5.1 git tag,
# use the corresponding commit sha instead
LIBMPEG2_VERSION_SHA = 41f78cf4d30d0da0a24c8ecbc38b0c9dfd43f871
LIBMPEG2_SOURCE = libmpeg2-v$(LIBMPEG2_VERSION_SHA).tar.gz
LIBMPEG2_SITE = https://code.videolan.org/videolan/libmpeg2/-/archive/$(LIBMPEG2_VERSION_SHA)
LIBMPEG2_LICENSE = GPL-2.0+
LIBMPEG2_LICENSE_FILES = COPYING
LIBMPEG2_INSTALL_STAGING = YES
LIBMPEG2_AUTORECONF = YES
LIBMPEG2_CONF_OPTS = --without-x --disable-directx

LIBMPEG2_CPE_ID_VENDOR = videolan

ifeq ($(BR2_PACKAGE_SDL),y)
LIBMPEG2_CONF_ENV += ac_cv_prog_SDLCONFIG=$(STAGING_DIR)/usr/bin/sdl-config
LIBMPEG2_CONF_OPTS += --enable-sdl
LIBMPEG2_DEPENDENCIES += sdl
else
LIBMPEG2_CONF_OPTS += --disable-sdl
endif

ifneq ($(BR2_PACKAGE_LIBMPEG2_BINS),y)
define LIBMPEG2_REMOVE_BINS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,\
		mpeg2dec corrupt_mpeg2 extract_mpeg2)
endef

LIBMPEG2_POST_INSTALL_TARGET_HOOKS += LIBMPEG2_REMOVE_BINS
endif

$(eval $(autotools-package))
