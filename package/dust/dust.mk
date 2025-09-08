################################################################################
#
# dust
#
################################################################################

DUST_VERSION = 1.2.3
DUST_SITE = $(call github,bootandy,dust,v$(DUST_VERSION))
DUST_LICENSE = APACHE-2.0
DUST_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
