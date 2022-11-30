################################################################################
#
# matchbox-fakekey
#
################################################################################

MATCHBOX_FAKEKEY_VERSION = 0.3
MATCHBOX_FAKEKEY_SOURCE = libfakekey-$(MATCHBOX_FAKEKEY_VERSION).tar.bz2
MATCHBOX_FAKEKEY_SITE = \
	http://git.yoctoproject.org/cgit/cgit.cgi/libfakekey/snapshot
MATCHBOX_FAKEKEY_LICENSE = GPL-2.0+
MATCHBOX_FAKEKEY_LICENSE_FILES = src/libfakekey.c
# From git
MATCHBOX_FAKEKEY_AUTORECONF = YES
MATCHBOX_FAKEKEY_INSTALL_STAGING = YES
MATCHBOX_FAKEKEY_DEPENDENCIES = matchbox-lib xlib_libXtst
MATCHBOX_FAKEKEY_CONF_OPTS = --enable-expat

define MATCHBOX_FAKEKEY_POST_CONFIGURE_FIXES
	$(SED) 's:^SUBDIRS = fakekey src tests.*:SUBDIRS = fakekey src:g' \
		$(@D)/Makefile
endef

MATCHBOX_FAKEKEY_POST_CONFIGURE_HOOKS += MATCHBOX_FAKEKEY_POST_CONFIGURE_FIXES

$(eval $(autotools-package))
