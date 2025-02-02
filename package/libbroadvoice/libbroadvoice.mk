################################################################################
#
# libbroadvoice
#
################################################################################

LIBBROADVOICE_VERSION = f65b0f50c8c767229fbf1758370880abc0d78564
# we use the FreeSwitch fork because (quoting README):
# "This library is based on the Broadcom reference code, but has been
# heavily modified so that it builds into a proper library, with a clean
# usable interface, on a range of platforms."
LIBBROADVOICE_SITE = $(call github,freeswitch,libbroadvoice,$(LIBBROADVOICE_VERSION))
LIBBROADVOICE_LICENSE = LGPL-2.1
LIBBROADVOICE_LICENSE_FILES = COPYING
LIBBROADVOICE_AUTORECONF = YES
LIBBROADVOICE_INSTALL_STAGING = YES

$(eval $(autotools-package))
