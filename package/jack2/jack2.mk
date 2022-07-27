################################################################################
#
# jack2
#
################################################################################

JACK2_VERSION = 1.9.20
JACK2_SITE = $(call github,jackaudio,jack2,v$(JACK2_VERSION))
JACK2_LICENSE = GPL-2.0+ (jack server), LGPL-2.1+ (jack library)
JACK2_LICENSE_FILES = COPYING
JACK2_CPE_ID_VENDOR = jackaudio
JACK2_DEPENDENCIES = alsa-lib
JACK2_INSTALL_STAGING = YES

JACK2_CONF_OPTS = --alsa --example-tools=no

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
JACK2_DEPENDENCIES += libexecinfo
JACK2_CONF_ENV += LDFLAGS="$(TARGET_LDFLAGS) -lexecinfo"
endif

ifeq ($(BR2_PACKAGE_LIBSAMPLERATE),y)
JACK2_DEPENDENCIES += libsamplerate
JACK2_CONF_OPTS += --samplerate=yes
else
JACK2_CONF_OPTS += --samplerate=no
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
JACK2_DEPENDENCIES += libsndfile
JACK2_CONF_OPTS += --sndfile=yes
else
JACK2_CONF_OPTS += --sndfile=no
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
JACK2_DEPENDENCIES += opus
JACK2_CONF_OPTS += --opus=yes
else
JACK2_CONF_OPTS += --opus=no
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
JACK2_DEPENDENCIES += readline
JACK2_CONF_OPTS += --readline=yes
else
JACK2_CONF_OPTS += --readline=no
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
JACK2_DEPENDENCIES += systemd
JACK2_CONF_OPTS += --systemd=yes
else
JACK2_CONF_OPTS += --systemd=no
endif

ifeq ($(BR2_PACKAGE_JACK2_LEGACY),y)
JACK2_CONF_OPTS += --classic
else
define JACK2_REMOVE_JACK_CONTROL
	$(RM) -f $(TARGET_DIR)/usr/bin/jack_control
endef
JACK2_POST_INSTALL_TARGET_HOOKS += JACK2_REMOVE_JACK_CONTROL
endif

ifeq ($(BR2_PACKAGE_JACK2_DBUS),y)
JACK2_DEPENDENCIES += dbus
JACK2_CONF_OPTS += --dbus
endif

# The dependency against eigen is only useful in conjunction with
# gtkiostream, which we do not have, so we don't need to depend on
# eigen.

$(eval $(waf-package))
