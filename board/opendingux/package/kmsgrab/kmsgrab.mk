#############################################################
#
# kmsgrab
#
#############################################################
KMSGRAB_VERSION = 22916bd
KMSGRAB_SITE = $(call github,pcercuei,kmsgrab,$(KMSGRAB_VERSION))
KMSGRAB_LICENSE = GPLv2

KMSGRAB_DEPENDENCIES = libdrm libpng

$(eval $(cmake-package))
