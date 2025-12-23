################################################################################
#
# sbctl
#
################################################################################

SBCTL_VERSION = 0.18
SBCTL_SITE = $(call github,foxboron,sbctl,$(SBCTL_VERSION))
SBCTL_LICENSE = MIT
SBCTL_LICENSE_FILES = LICENSE
SBCTL_BUILD_TARGETS = cmd/sbctl
SBCTL_DEPENDENCIES = pcsc-lite

$(eval $(golang-package))
