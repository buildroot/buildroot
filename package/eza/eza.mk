################################################################################
#
# eza
#
################################################################################

EZA_VERSION = 0.20.19
EZA_SITE = $(call github,eza-community,eza,v$(EZA_VERSION))
EZA_LICENSE = EUPL-1.2
EZA_LICENSE_FILES = LICENSE.txt

$(eval $(cargo-package))
