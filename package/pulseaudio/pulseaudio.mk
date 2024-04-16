################################################################################
#
# pulseaudio
#
################################################################################

PULSEAUDIO_VERSION = 17.0
PULSEAUDIO_SOURCE = pulseaudio-$(PULSEAUDIO_VERSION).tar.xz
PULSEAUDIO_SITE = https://freedesktop.org/software/pulseaudio/releases
PULSEAUDIO_INSTALL_STAGING = YES
PULSEAUDIO_LICENSE = LGPL-2.1+ (specific license for modules, see LICENSE file)
PULSEAUDIO_LICENSE_FILES = LICENSE GPL LGPL
PULSEAUDIO_CPE_ID_VENDOR = pulseaudio
PULSEAUDIO_SELINUX_MODULES = pulseaudio xdg
PULSEAUDIO_CONF_OPTS = \
	-Ddoxygen=false \
	-Dlegacy-database-entry-format=false \
	-Dman=false \
	-Drunning-from-build-tree=false \
	-Dtests=false

PULSEAUDIO_DEPENDENCIES = \
	host-pkgconf libtool libsndfile libglib2 \
	$(TARGET_NLS_DEPENDENCIES)

PULSEAUDIO_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

ifeq ($(BR2_PACKAGE_AVAHI_LIBAVAHI_CLIENT),y)
PULSEAUDIO_CONF_OPTS += -Davahi=enabled
PULSEAUDIO_DEPENDENCIES += avahi
else
PULSEAUDIO_CONF_OPTS += -Davahi=disabled
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
PULSEAUDIO_CONF_OPTS += -Ddbus=enabled
PULSEAUDIO_DEPENDENCIES += dbus
else
PULSEAUDIO_CONF_OPTS += -Ddbus=disabled
endif

ifeq ($(BR2_PACKAGE_FFTW_SINGLE),y)
PULSEAUDIO_CONF_OPTS += -Dfftw=enabled
PULSEAUDIO_DEPENDENCIES += fftw-single
else
PULSEAUDIO_CONF_OPTS += -Dfftw=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSAMPLERATE),y)
PULSEAUDIO_CONF_OPTS += -Dsamplerate=enabled
PULSEAUDIO_DEPENDENCIES += libsamplerate
else
PULSEAUDIO_CONF_OPTS += -Dsamplerate=disabled
endif

ifeq ($(BR2_PACKAGE_GDBM),y)
PULSEAUDIO_CONF_OPTS += -Ddatabase=gdbm
PULSEAUDIO_DEPENDENCIES += gdbm
else
PULSEAUDIO_CONF_OPTS += -Ddatabase=simple
endif

ifeq ($(BR2_PACKAGE_JACK2),y)
PULSEAUDIO_CONF_OPTS += -Djack=enabled
PULSEAUDIO_DEPENDENCIES += jack2
else
PULSEAUDIO_CONF_OPTS += -Djack=disabled
endif

ifeq ($(BR2_PACKAGE_LIBATOMIC_OPS),y)
PULSEAUDIO_DEPENDENCIES += libatomic_ops
ifeq ($(BR2_sparc_v8)$(BR2_sparc_leon3),y)
PULSEAUDIO_CFLAGS = $(TARGET_CFLAGS) -DAO_NO_SPARC_V9
endif
endif

ifeq ($(BR2_PACKAGE_LIRC_TOOLS),y)
PULSEAUDIO_DEPENDENCIES += lirc-tools
PULSEAUDIO_CONF_OPTS += -Dlirc=enabled
else
PULSEAUDIO_CONF_OPTS += -Dlirc=disabled
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
PULSEAUDIO_CONF_OPTS += -Dopenssl=enabled
PULSEAUDIO_DEPENDENCIES += openssl
else
PULSEAUDIO_CONF_OPTS += -Dopenssl=disabled
endif

ifeq ($(BR2_PACKAGE_ORC),y)
PULSEAUDIO_DEPENDENCIES += orc
PULSEAUDIO_CONF_ENV += ORCC=$(HOST_DIR)/bin/orcc
PULSEAUDIO_CONF_OPTS += -Dorc=enabled
else
PULSEAUDIO_CONF_OPTS += -Dorc=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
PULSEAUDIO_DEPENDENCIES += libcap
endif

# gtk3 support needs X11 backend
ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
PULSEAUDIO_DEPENDENCIES += libgtk3
PULSEAUDIO_CONF_OPTS += -Dgtk=enabled
else
PULSEAUDIO_CONF_OPTS += -Dgtk=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSOXR),y)
PULSEAUDIO_CONF_OPTS += -Dsoxr=enabled
PULSEAUDIO_DEPENDENCIES += libsoxr
else
PULSEAUDIO_CONF_OPTS += -Dsoxr=disabled
endif

ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS)$(BR2_PACKAGE_SBC),yy)
PULSEAUDIO_CONF_OPTS += -Dbluez5=enabled
PULSEAUDIO_DEPENDENCIES += bluez5_utils sbc
else
PULSEAUDIO_CONF_OPTS += -Dbluez5=disabled
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
PULSEAUDIO_CONF_OPTS += -Dudev=enabled
PULSEAUDIO_DEPENDENCIES += udev
else
PULSEAUDIO_CONF_OPTS += -Dudev=disabled
endif

ifeq ($(BR2_PACKAGE_WEBRTC_AUDIO_PROCESSING),y)
PULSEAUDIO_CONF_OPTS += -Dwebrtc-aec=enabled
PULSEAUDIO_DEPENDENCIES += webrtc-audio-processing
else
PULSEAUDIO_CONF_OPTS += -Dwebrtc-aec=disabled
endif

# our Config.in makes sure that all needed alsa-lib features are
# enabled
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
PULSEAUDIO_DEPENDENCIES += alsa-lib
PULSEAUDIO_CONF_OPTS += -Dalsa=enabled
else
PULSEAUDIO_CONF_OPTS += -Dalsa=disabled
endif

ifeq ($(BR2_PACKAGE_LIBXCB)$(BR2_PACKAGE_XLIB_LIBSM)$(BR2_PACKAGE_XLIB_LIBXTST),yyy)
PULSEAUDIO_DEPENDENCIES += libxcb xlib_libSM xlib_libXtst

# .desktop file generation needs nls support, so fake it for !locale builds
# https://bugs.freedesktop.org/show_bug.cgi?id=54658
ifeq ($(BR2_SYSTEM_ENABLE_NLS),)
define PULSEAUDIO_FIXUP_DESKTOP_FILES
	cp $(@D)/src/daemon/pulseaudio.desktop.in \
		$(@D)/src/daemon/pulseaudio.desktop
endef
PULSEAUDIO_POST_PATCH_HOOKS += PULSEAUDIO_FIXUP_DESKTOP_FILES
endif

else
PULSEAUDIO_CONF_OPTS += -Dx11=disabled
endif

# This is not a mistake: the option is called speex, but what it
# really needs is speexdsp
ifeq ($(BR2_PACKAGE_SPEEXDSP),y)
PULSEAUDIO_CONF_OPTS += -Dspeex=enabled
PULSEAUDIO_DEPENDENCIES += speexdsp
else
PULSEAUDIO_CONF_OPTS += -Dspeex=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
PULSEAUDIO_CONF_OPTS += -Dsystemd=enabled
PULSEAUDIO_DEPENDENCIES += systemd
else
PULSEAUDIO_CONF_OPTS += -Dsystemd=disabled
endif

ifeq ($(BR2_PACKAGE_VALGRIND),y)
PULSEAUDIO_CONF_OPTS += -Dvalgrind=enabled
PULSEAUDIO_DEPENDENCIES += valgrind
else
PULSEAUDIO_CONF_OPTS += -Dvalgrind=disabled
endif

# ConsoleKit module init failure breaks user daemon startup
define PULSEAUDIO_REMOVE_CONSOLE_KIT
	rm -f $(TARGET_DIR)/usr/lib/pulse-$(PULSEAUDIO_VERSION)/modules/module-console-kit.so
endef

define PULSEAUDIO_REMOVE_VALA
	rm -rf $(TARGET_DIR)/usr/share/vala
endef

PULSEAUDIO_POST_INSTALL_TARGET_HOOKS += PULSEAUDIO_REMOVE_VALA \
	PULSEAUDIO_REMOVE_CONSOLE_KIT

ifeq ($(BR2_PACKAGE_PULSEAUDIO_DAEMON),y)
define PULSEAUDIO_USERS
	pulse -1 pulse -1 * /var/run/pulse - audio,pulse-access
endef

define PULSEAUDIO_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/pulseaudio/S50pulseaudio \
		$(TARGET_DIR)/etc/init.d/S50pulseaudio
endef

define PULSEAUDIO_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/pulseaudio/pulseaudio.service \
		$(TARGET_DIR)/usr/lib/systemd/system/pulseaudio.service
endef

endif

$(eval $(meson-package))
