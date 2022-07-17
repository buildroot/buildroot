################################################################################
#
# crucible
#
################################################################################

CRUCIBLE_VERSION = v2022.05.25
CRUCIBLE_SITE = $(call github,usbarmory,crucible,$(CRUCIBLE_VERSION))
CRUCIBLE_LICENSE = GPL-3.0
CRUCIBLE_LICENSE_FILES = LICENSE
CRUCIBLE_GOMOD = ./cmd/crucible

$(eval $(golang-package))
