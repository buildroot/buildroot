################################################################################
#
# eza
#
################################################################################

EZA_VERSION = 0.16.0
EZA_SITE = $(call github,eza-community,eza,v$(EZA_VERSION))
EZA_LICENSE = MIT
EZA_LICENSE_FILES = LICENCE

$(eval $(cargo-package))
