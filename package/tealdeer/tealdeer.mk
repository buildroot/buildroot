################################################################################
#
# tealdeer
#
################################################################################

TEALDEER_VERSION = 1.6.1
TEALDEER_SITE = $(call github,dbrgn,tealdeer,v$(TEALDEER_VERSION))
TEALDEER_LICENSE = Apache-2.0 or MIT
TEALDEER_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

$(eval $(cargo-package))
