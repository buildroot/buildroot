################################################################################
#
# sdl3_image
#
################################################################################

SDL3_IMAGE_VERSION = 3.1.1
SDL3_IMAGE_SITE = https://www.libsdl.org/projects/SDL_image/release
SDL3_IMAGE_SOURCE = SDL3_image-$(SDL3_IMAGE_VERSION).tar.gz
SDL3_IMAGE_LICENSE = Zlib
SDL3_IMAGE_LICENSE_FILES = LICENSE.txt
SDL3_IMAGE_INSTALL_STAGING = YES
SDL3_IMAGE_DEPENDENCIES = sdl3

ifeq ($(BR2_PACKAGE_LIBPNG),y)
SDL3_IMAGE_DEPENDENCIES += libpng
SDL3_IMAGE_CONF_OPTS += -DSDLIMAGE_PNG=ON
else
SDL3_IMAGE_CONF_OPTS += -DSDLIMAGE_PNG=OFF
endif

$(eval $(cmake-package))
