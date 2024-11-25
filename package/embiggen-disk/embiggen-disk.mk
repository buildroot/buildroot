################################################################################
#
# embiggen-disk
#
################################################################################

EMBIGGEN_DISK_VERSION = v20240521
EMBIGGEN_DISK_SITE = $(call github,skiffos,embiggen-disk,$(EMBIGGEN_DISK_VERSION))
EMBIGGEN_DISK_LICENSE = Apache-2.0
EMBIGGEN_DISK_LICENSE_FILES = LICENSE

$(eval $(golang-package))
