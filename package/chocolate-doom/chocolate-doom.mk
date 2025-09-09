################################################################################
#
# chocolate-doom
#
################################################################################

CHOCOLATE_DOOM_VERSION = 3.1.1
CHOCOLATE_DOOM_SITE = $(call github,chocolate-doom,chocolate-doom,chocolate-doom-$(CHOCOLATE_DOOM_VERSION))
CHOCOLATE_DOOM_LICENSE = GPL-2.0+
CHOCOLATE_DOOM_LICENSE_FILES = COPYING.md
CHOCOLATE_DOOM_CPE_ID_VENDOR = chocolate-doom
CHOCOLATE_DOOM_CPE_ID_PRODUCT = chocolate_doom
CHOCOLATE_DOOM_DEPENDENCIES = host-pkgconf sdl2
# Fetch from git
CHOCOLATE_DOOM_AUTORECONF = YES

# Avoid installing desktop entries, icons, etc.
CHOCOLATE_DOOM_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) install-exec

CHOCOLATE_DOOM_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
CHOCOLATE_DOOM_CFLAGS += -O0
endif

CHOCOLATE_DOOM_CONF_ENV += CFLAGS="$(CHOCOLATE_DOOM_CFLAGS)"

ifeq ($(BR2_PACKAGE_SDL2_MIXER),y)
CHOCOLATE_DOOM_DEPENDENCIES += sdl2_mixer
CHOCOLATE_DOOM_CONF_OPTS += --enable-sdl2mixer
else
CHOCOLATE_DOOM_CONF_OPTS += --disable-sdl2mixer
endif

ifeq ($(BR2_PACKAGE_SDL2_NET),y)
CHOCOLATE_DOOM_DEPENDENCIES += sdl2_net
CHOCOLATE_DOOM_CONF_OPTS += --enable-sdl2net
else
CHOCOLATE_DOOM_CONF_OPTS += --disable-sdl2net
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
CHOCOLATE_DOOM_DEPENDENCIES += libpng
CHOCOLATE_DOOM_CONF_OPTS += --with-libpng
else
CHOCOLATE_DOOM_CONF_OPTS += --without-libpng
endif

ifeq ($(BR2_PACKAGE_LIBSAMPLERATE),y)
CHOCOLATE_DOOM_DEPENDENCIES += libsamplerate
CHOCOLATE_DOOM_CONF_OPTS += --with-libsamplerate
else
CHOCOLATE_DOOM_CONF_OPTS += --without-libsamplerate
endif

$(eval $(autotools-package))
