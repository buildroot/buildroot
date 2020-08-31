################################################################################
#
# mrp
#
################################################################################

MRP_VERSION = 1.1
MRP_SITE = $(call github,microchip-ung,mrp,v$(MRP_VERSION))
MRP_DEPENDENCIES = libev libmnl libnl
MRP_LICENSE = GPL-2.0
MRP_LICENSE_FILES = LICENSE

$(eval $(cmake-package))
