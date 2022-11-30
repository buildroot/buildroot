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
ZYNADDSUBFX_CONF_OPTS = -DCompileTests=OFF -DPluginEnable=OFF

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
ZYNADDSUBFX_CONF_OPTS += -DOS_LIBRARIES=-latomic
endif

ZYNADDSUBFX_DEPENDENCIES = \
	fftw-single \
	liblo \
	mxml \
	zlib

ifeq ($(BR2_PACKAGE_ALSA_LIB_SEQ),y)
ZYNADDSUBFX_DEPENDENCIES += alsa-lib
ZYNADDSUBFX_CONF_OPTS += -DAlsaEnable=ON
else
ZYNADDSUBFX_CONF_OPTS += -DAlsaEnable=OFF
endif

ifeq ($(BR2_PACKAGE_JACK1)$(BR2_PACKAGE_JACK2),y)
ZYNADDSUBFX_DEPENDENCIES += $(if $(BR2_PACKAGE_JACK1),jack1,jack2)
ZYNADDSUBFX_CONF_OPTS += -DJackEnable=ON
else
ZYNADDSUBFX_CONF_OPTS += -DJackEnable=OFF
endif

ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
ZYNADDSUBFX_DEPENDENCIES += portaudio
ZYNADDSUBFX_CONF_OPTS += -DPaEnable=ON
else
ZYNADDSUBFX_CONF_OPTS += -DPaEnable=OFF
endif

$(eval $(cmake-package))
