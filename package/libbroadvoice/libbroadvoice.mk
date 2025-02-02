################################################################################
#
# libbroadvoice
#
################################################################################

LIBBROADVOICE_VERSION = 03dd05df52f093bbf7820e68707f3a3668e73507
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
