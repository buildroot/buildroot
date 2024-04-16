################################################################################
#
# matchbox-keyboard
#
################################################################################

MATCHBOX_KEYBOARD_VERSION = 0.1.1
MATCHBOX_KEYBOARD_SOURCE = matchbox-keyboard-$(MATCHBOX_KEYBOARD_VERSION).tar.bz2
MATCHBOX_KEYBOARD_SITE = \
	http://git.yoctoproject.org/cgit/cgit.cgi/matchbox-keyboard/snapshot
MATCHBOX_KEYBOARD_LICENSE = LGPL-2.1, GPL-2.0+ (applet.c)
MATCHBOX_KEYBOARD_LICENSE_FILES = COPYING applet/applet.c
MATCHBOX_KEYBOARD_DEPENDENCIES = \
	host-pkgconf matchbox-lib matchbox-fakekey expat libpng xlib_libXrender
# From git
MATCHBOX_KEYBOARD_AUTORECONF = YES

define MATCHBOX_KEYBOARD_POST_INSTALL_FIXES
	$(INSTALL) -D -m 0755 package/matchbox-keyboard/mb-applet-kbd-wrapper.sh \
		$(TARGET_DIR)/usr/bin/mb-applet-kbd-wrapper.sh
endef

MATCHBOX_KEYBOARD_POST_INSTALL_TARGET_HOOKS += MATCHBOX_KEYBOARD_POST_INSTALL_FIXES

ifeq ($(BR2_PACKAGE_CAIRO),y)
MATCHBOX_KEYBOARD_CONF_OPTS += --enable-cairo
MATCHBOX_KEYBOARD_DEPENDENCIES += cairo
else
MATCHBOX_KEYBOARD_CONF_OPTS += --disable-cairo
MATCHBOX_KEYBOARD_DEPENDENCIES += xlib_libXft
endif

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
MATCHBOX_KEYBOARD_CONF_OPTS += --enable-gtk3-im
MATCHBOX_KEYBOARD_DEPENDENCIES += libgtk3
else
MATCHBOX_KEYBOARD_CONF_OPTS += --disable-gtk3-im
endif

$(eval $(autotools-package))
