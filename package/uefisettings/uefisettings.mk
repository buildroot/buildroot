################################################################################
#
# uefisettings
#
################################################################################

UEFISETTINGS_VERSION = 149bc92970949d44be641ae1e3e942220d7390e7
UEFISETTINGS_SITE = $(call github,linuxboot,uefisettings,$(UEFISETTINGS_VERSION))
UEFISETTINGS_LICENSE = BSD-3-Clause
UEFISETTINGS_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
