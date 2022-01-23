################################################################################
#
# zynaddsubfx
#
################################################################################

ZYNADDSUBFX_VERSION = 3.0.6
ZYNADDSUBFX_SOURCE = zynaddsubfx-$(ZYNADDSUBFX_VERSION).tar.bz2
ZYNADDSUBFX_SITE = http://downloads.sourceforge.net/zynaddsubfx
ZYNADDSUBFX_LICENSE = GPL-2.0+
ZYNADDSUBFX_LICENSE_FILES = COPYING

# There is no package in buildroot using LV2 plugins: disabling
ZYNADDSUBFX_CONF_OPTS = -DPluginEnable=False

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
ZYNADDSUBFX_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ZYNADDSUBFX_DEPENDENCIES = \
	alsa-lib \
	fftw-single \
	liblo \
	mxml \
	zlib

$(eval $(cmake-package))
