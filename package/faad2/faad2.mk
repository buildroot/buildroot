################################################################################
#
# faad2
#
################################################################################

FAAD2_VERSION = 2.11.1
FAAD2_SITE = $(call github,knik0,faad2,$(FAAD2_VERSION))
FAAD2_LICENSE = GPL-2.0
FAAD2_LICENSE_FILES = COPYING
FAAD2_CPE_ID_VENDOR = audiocoding
FAAD2_CPE_ID_PRODUCT = freeware_advanced_audio_decoder_2
FAAD2_INSTALL_STAGING = YES

# faad2 contains assembly routines using ARM instructions not present in thumb1 mode:
# Error: selected processor does not support `smull r2,r3,r1,r0' in Thumb mode
# so force ARM mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
FAAD2_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -marm"
endif

$(eval $(cmake-package))
