################################################################################
#
# sdl_net
#
################################################################################

# The latest officially released version of SDL_image is 1.2.8, released in 2012.
# Since then, there have been several bugfixes.
#
# This commit points to the SDL-1.2 branch from 18 Feb 2021.
SDL_NET_VERSION = 620b0ba7dd84a0fdbd4cc8ef1b2be1cc10f90ae3
SDL_NET_SITE = $(call github,libsdl-org,SDL_net,$(SDL_NET_VERSION))
SDL_NET_SOURCE = SDL_net-$(SDL_NET_VERSION).tar.gz
SDL_NET_LICENSE = Zlib
SDL_NET_LICENSE_FILES = COPYING

SDL_NET_CONF_OPTS = \
	--with-sdl-prefix=$(STAGING_DIR)/usr \
	--with-sdl-exec-prefix=$(STAGING_DIR)/usr

SDL_NET_INSTALL_STAGING = YES

SDL_NET_DEPENDENCIES = sdl

$(eval $(autotools-package))
