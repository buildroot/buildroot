################################################################################
#
# dtui
#
################################################################################

DTUI_VERSION = 3.1.1
DTUI_SITE = $(call github,Troels51,dtui,v$(DTUI_VERSION))

DTUI_LICENSE = MIT
DTUI_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
