################################################################################
#
# tllist
#
################################################################################

TLLIST_VERSION = 1.1.0
TLLIST_SOURCE = $(TLLIST_VERSION).tar.gz
TLLIST_SITE = https://codeberg.org/dnkl/tllist/archive
TLLIST_LICENSE = MIT
TLLIST_LICENSE_FILES = LICENSE
# header only
TLLIST_INSTALL_TARGET = NO
TLLIST_INSTALL_STAGING = YES
TLLIST_CFLAGS = $(TARGET_CFLAGS) -std=c99

$(eval $(meson-package))
