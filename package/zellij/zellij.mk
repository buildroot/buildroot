################################################################################
#
# zellij
#
################################################################################

ZELLIJ_VERSION = 0.45.1
ZELLIJ_SITE = $(call github,zellij-org,zellij,v$(ZELLIJ_VERSION))
ZELLIJ_LICENSE = MIT
ZELLIJ_LICENSE_FILES = LICENSE.md

$(eval $(cargo-package))
