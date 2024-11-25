################################################################################
#
# uefisettings
#
################################################################################

UEFISETTINGS_VERSION = f90aed759b9c2217bea336e37ab5282616ece390
UEFISETTINGS_SITE = $(call github,linuxboot,uefisettings,$(UEFISETTINGS_VERSION))
UEFISETTINGS_LICENSE = BSD-3-Clause
UEFISETTINGS_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
