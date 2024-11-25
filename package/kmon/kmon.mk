################################################################################
#
# kmon
#
################################################################################

KMON_VERSION = 1.6.5
KMON_SITE = $(call github,orhun,kmon,v$(KMON_VERSION))
KMON_LICENSE = GPL-3.0
KMON_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
