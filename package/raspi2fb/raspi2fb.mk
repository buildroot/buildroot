################################################################################
#
# raspi2fb
#
################################################################################

RASPI2FB_VERSION = 644454b959a25b3df754a5f1d309a1cf2d12f543
RASPI2FB_SITE = $(call github,AndrewFromMelbourne,raspi2fb,$(RASPI2FB_VERSION))
RASPI2FB_LICENSE = MIT
RASPI2FB_LICENSE_FILES = LICENSE
RASPI2FB_DEPENDENCIES = libbsd rpi-userland

$(eval $(cmake-package))
