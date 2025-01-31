################################################################################
#
# zoxide
#
################################################################################

ZOXIDE_VERSION = 0.9.6
ZOXIDE_SITE = $(call github,ajeetdsouza,zoxide,v$(ZOXIDE_VERSION))
ZOXIDE_LICENSE = MIT
ZOXIDE_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
