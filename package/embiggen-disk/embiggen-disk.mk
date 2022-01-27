################################################################################
#
# embiggen-disk
#
################################################################################

EMBIGGEN_DISK_VERSION = 9e7b2fc7b99c4dece41a805489a6ca377ce55a62
EMBIGGEN_DISK_SITE = $(call github,bradfitz,embiggen-disk,$(EMBIGGEN_DISK_VERSION))
EMBIGGEN_DISK_LICENSE = Apache-2.0
EMBIGGEN_DISK_LICENSE_FILES = LICENSE

$(eval $(golang-package))
