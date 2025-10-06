################################################################################
#
# libtheora
#
################################################################################

LIBTHEORA_VERSION = 1.2.0
LIBTHEORA_SOURCE = libtheora-$(LIBTHEORA_VERSION).tar.xz
LIBTHEORA_SITE = http://downloads.xiph.org/releases/theora
LIBTHEORA_INSTALL_STAGING = YES
# We're patching Makefile.am
LIBTHEORA_AUTORECONF = YES
LIBTHEORA_LICENSE = BSD-3-Clause
LIBTHEORA_LICENSE_FILES = COPYING LICENSE

LIBTHEORA_CONF_OPTS = \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-sdltest \
	--disable-examples \
	--disable-spec

# assembly code on arm is broken:
# https://gitlab.xiph.org/xiph/theora/-/merge_requests/53
ifeq ($(BR2_arm),y)
LIBTHEORA_CONF_OPTS += --disable-asm
endif

LIBTHEORA_DEPENDENCIES = libogg libvorbis host-pkgconf

$(eval $(autotools-package))
