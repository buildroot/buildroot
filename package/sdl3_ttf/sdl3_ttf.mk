################################################################################
#
# sdl3_ttf
#
################################################################################

SDL3_TTF_VERSION = 3.2.2
SDL3_TTF_SOURCE = SDL3_ttf-$(SDL3_TTF_VERSION).tar.gz
SDL3_TTF_SITE = https://www.libsdl.org/projects/SDL_ttf/release
SDL3_TTF_LICENSE = Zlib
SDL3_TTF_LICENSE_FILES = LICENSE.txt
SDL3_TTF_INSTALL_STAGING = YES

SDL3_TTF_DEPENDENCIES = sdl3 freetype host-pkgconf

SDL3_TTF_CONF_OPTS = \
	-DSDLTTF_VENDORED=OFF \
	-DSDLTTF_HARFBUZZ=OFF

ifeq ($(BR2_PACKAGE_HARFBUZZ),y)
SDL3_TTF_DEPENDENCIES += harfbuzz
SDL3_TTF_CONF_OPTS += -DSDLTTF_HARFBUZZ=ON
endif

$(eval $(cmake-package))
