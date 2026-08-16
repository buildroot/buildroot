################################################################################
#
# sdl3_net
#
################################################################################

SDL3_NET_VERSION = 3.2.0
SDL3_NET_SOURCE = SDL3_net-$(SDL3_NET_VERSION).tar.gz
SDL3_NET_SITE = https://www.libsdl.org/projects/SDL_net/release
SDL3_NET_LICENSE = Zlib
SDL3_NET_LICENSE_FILES = LICENSE.txt
SDL3_NET_INSTALL_STAGING = YES
SDL3_NET_DEPENDENCIES = sdl3 host-pkgconf

SDL3_NET_CONF_OPTS = \
	-DSDLNET_SAMPLES=OFF \
	-DSDLNET_INSTALL_MAN=OFF

$(eval $(cmake-package))
