################################################################################
#
# crucible
#
################################################################################

CRUCIBLE_VERSION = 2025.05.28
CRUCIBLE_SITE = $(call github,usbarmory,crucible,v$(CRUCIBLE_VERSION))
CRUCIBLE_LICENSE = BSD-3-Clause
CRUCIBLE_LICENSE_FILES = LICENSE
CRUCIBLE_GOMOD = ./cmd/crucible

$(eval $(golang-package))
