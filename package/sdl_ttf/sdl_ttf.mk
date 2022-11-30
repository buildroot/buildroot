################################################################################
#
# sdl_ttf
#
################################################################################

# There is unlikely to be a new SDL_ttf release for the foreseeable future:
# https://bugzilla.libsdl.org/show_bug.cgi?id=5344#c1
SDL_TTF_VERSION = 70b2940cc75e92aab02a67d2f827caf2836a2c74
SDL_TTF_SITE = $(call github,libsdl-org,SDL_ttf,$(SDL_TTF_VERSION))
SDL_TTF_LICENSE = Zlib
SDL_TTF_LICENSE_FILES = COPYING

SDL_TTF_INSTALL_STAGING = YES
SDL_TTF_DEPENDENCIES = sdl freetype
SDL_TTF_CONF_OPTS = \
	--without-x \
	--with-freetype-prefix=$(STAGING_DIR)/usr \
	--with-sdl-prefix=$(STAGING_DIR)/usr

SDL_TTF_MAKE_OPTS = \
	INCLUDES="-I$(STAGING_DIR)/usr/include/SDL" \
	LDFLAGS="-L$(STAGING_DIR)/usr/lib"

$(eval $(autotools-package))
