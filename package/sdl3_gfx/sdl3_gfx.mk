################################################################################
#
# sdl3_gfx
#
################################################################################

SDL3_GFX_VERSION = 1.0.1
SDL3_GFX_SITE = $(call github,sabdul-khabir,SDL3_gfx,v$(SDL3_GFX_VERSION))
SDL3_GFX_LICENSE = Zlib
SDL3_GFX_LICENSE_FILES = COPYING
SDL3_GFX_INSTALL_STAGING = YES
SDL3_GFX_DEPENDENCIES = sdl3 host-pkgconf

SDL3_GFX_CONF_OPTS = \
	-DSDL3_GFX_TESTS=OFF \
	-DSDL3_GFX_INSTALL=ON

ifeq ($(BR2_i386)$(BR2_X86_CPU_HAS_MMX),yy)
SDL3_GFX_CONF_OPTS += -DSDL3_GFX_MMX=ON
else
SDL3_GFX_CONF_OPTS += -DSDL3_GFX_MMX=OFF
endif

$(eval $(cmake-package))
