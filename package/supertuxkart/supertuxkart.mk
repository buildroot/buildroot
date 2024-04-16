################################################################################
#
# supertuxkart
#
################################################################################

SUPERTUXKART_VERSION = 1.4
SUPERTUXKART_SOURCE = SuperTuxKart-$(SUPERTUXKART_VERSION)-src.tar.xz
# Do not use the github helper here, the generated tarball is *NOT*
# the same as the one uploaded by upstream for the release.
SUPERTUXKART_SITE = https://github.com/supertuxkart/stk-code/releases/download/$(SUPERTUXKART_VERSION)

# Supertuxkart itself is GPL-3.0+, but it bundles a few libraries with different
# licenses. Irrlicht, bullet and angelscript have Zlib license, while glew is
# BSD-3-Clause. Since they are linked statically, the result is GPL-3.0+.
SUPERTUXKART_LICENSE = GPL-3.0+
SUPERTUXKART_LICENSE_FILES = COPYING

SUPERTUXKART_DEPENDENCIES = \
	host-pkgconf \
	freetype \
	enet \
	harfbuzz \
	jpeg \
	libcurl \
	libgl \
	libogg \
	libpng \
	libsquish \
	libvorbis \
	openal \
	sdl2 \
	xlib_libXrandr \
	zlib

# Since supertuxkart is not installing libstkirrlicht.so, and since it is
# the only user of the bundled libraries, turn off shared libraries entirely.
# Disable In-game recorder (there is no libopenglrecorder package)
SUPERTUXKART_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF \
	-DBUILD_RECORDER=OFF \
	-DUSE_SYSTEM_ENET=ON \
	-DUSE_SYSTEM_SQUISH=ON

ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS),y)
SUPERTUXKART_DEPENDENCIES += bluez5_utils
SUPERTUXKART_CONF_OPTS += -DUSE_WIIUSE=ON -DUSE_SYSTEM_WIIUSE=ON
SUPERTUXKART_SUPPORTS_IN_SOURCE_BUILD = NO
else
# Wiimote support relies on bluez5.
SUPERTUXKART_CONF_OPTS += -DUSE_WIIUSE=OFF
endif

# Prefer openssl (the default) over mbedtls
ifeq ($(BR2_PACKAGE_OPENSSL),y)
SUPERTUXKART_DEPENDENCIES += openssl
SUPERTUXKART_CONF_OPTS += -DUSE_CRYPTO_OPENSSL=ON
else
SUPERTUXKART_DEPENDENCIES += mbedtls
SUPERTUXKART_CONF_OPTS += -DUSE_CRYPTO_OPENSSL=OFF
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
SUPERTUXKART_DEPENDENCIES += sqlite
SUPERTUXKART_CONF_OPTS += -DUSE_SQLITE3=ON
else
SUPERTUXKART_CONF_OPTS += -DUSE_SQLITE3=OFF
endif

$(eval $(cmake-package))
