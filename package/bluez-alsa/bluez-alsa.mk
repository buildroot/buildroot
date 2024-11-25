################################################################################
#
# bluez-alsa
#
################################################################################

BLUEZ_ALSA_VERSION = 4.3.1
BLUEZ_ALSA_SITE = $(call github,Arkq,bluez-alsa,v$(BLUEZ_ALSA_VERSION))
BLUEZ_ALSA_LICENSE = MIT
BLUEZ_ALSA_LICENSE_FILES = LICENSE
BLUEZ_ALSA_DEPENDENCIES = alsa-lib bluez5_utils libglib2 sbc host-pkgconf

# git repo, no configure
BLUEZ_ALSA_AUTORECONF = YES

BLUEZ_ALSA_CONF_OPTS = \
	--enable-a2dpconf \
	--enable-aplay \
	--enable-cli \
	--disable-debug-time \
	--with-alsaplugindir=/usr/lib/alsa-lib \
	--with-alsaconfdir=/etc/alsa/conf.d

ifeq ($(BR2_PACKAGE_ALSA_PLUGINS),y)
BLUEZ_ALSA_DEPENDENCIES += alsa-plugins
endif

ifeq ($(BR2_PACKAGE_FDK_AAC),y)
BLUEZ_ALSA_DEPENDENCIES += fdk-aac
BLUEZ_ALSA_CONF_OPTS += --enable-aac
else
BLUEZ_ALSA_CONF_OPTS += --disable-aac
endif

ifeq ($(BR2_PACKAGE_LAME),y)
BLUEZ_ALSA_DEPENDENCIES += lame
BLUEZ_ALSA_CONF_OPTS += --enable-mp3lame
else
BLUEZ_ALSA_CONF_OPTS += --disable-mp3lame
endif

ifeq ($(BR2_PACKAGE_MPG123),y)
BLUEZ_ALSA_DEPENDENCIES += mpg123
BLUEZ_ALSA_CONF_OPTS += --enable-mpg123
else
BLUEZ_ALSA_CONF_OPTS += --disable-mpg123
endif

# no build dependency, disables internal HFP in favor of oFonos HFP profile
ifeq ($(BR2_PACKAGE_OFONO),y)
BLUEZ_ALSA_CONF_OPTS += --enable-ofono
else
BLUEZ_ALSA_CONF_OPTS += --disable-ofono
endif

# no build dependency, enables integration with UPower D-Bus service
ifeq ($(BR2_PACKAGE_UPOWER),y)
BLUEZ_ALSA_CONF_OPTS += --enable-upower
else
BLUEZ_ALSA_CONF_OPTS += --disable-upower
endif

ifeq ($(BR2_PACKAGE_BLUEZ_ALSA_HCITOP),y)
BLUEZ_ALSA_DEPENDENCIES += libbsd ncurses
BLUEZ_ALSA_CONF_OPTS += --enable-hcitop
else
BLUEZ_ALSA_CONF_OPTS += --disable-hcitop
endif

ifeq ($(BR2_PACKAGE_BLUEZ_ALSA_RFCOMM),y)
BLUEZ_ALSA_DEPENDENCIES += readline
BLUEZ_ALSA_CONF_OPTS += --enable-rfcomm
else
BLUEZ_ALSA_CONF_OPTS += --disable-rfcomm
endif

ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS_PLUGINS_MIDI),y)
BLUEZ_ALSA_CONF_OPTS += --enable-midi
else
BLUEZ_ALSA_CONF_OPTS += --disable-midi
endif

ifeq ($(BR2_PACKAGE_LIBOPENAPTX),y)
BLUEZ_ALSA_DEPENDENCIES += libopenaptx
BLUEZ_ALSA_CONF_OPTS += --with-libopenaptx --enable-aptx --enable-aptx-hd
else
BLUEZ_ALSA_CONF_OPTS += --without-libopenaptx --disable-aptx --disable-aptx-hd
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
BLUEZ_ALSA_DEPENDENCIES += opus
BLUEZ_ALSA_CONF_OPTS += --enable-opus
else
BLUEZ_ALSA_CONF_OPTS += --disable-opus
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
BLUEZ_ALSA_DEPENDENCIES += systemd
BLUEZ_ALSA_CONF_OPTS += --enable-systemd
else
BLUEZ_ALSA_CONF_OPTS += --disable-systemd
endif

ifeq ($(BR2_PACKAGE_SPANDSP),y)
BLUEZ_ALSA_DEPENDENCIES += spandsp
BLUEZ_ALSA_CONF_OPTS += --enable-msbc
else
BLUEZ_ALSA_CONF_OPTS += --disable-msbc
endif

$(eval $(autotools-package))
