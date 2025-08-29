################################################################################
#
# brcm-patchram-plus
#
################################################################################

BRCM_PATCHRAM_PLUS_VERSION = 15bd6638dd6d3a37d22dbc18059f6d9eb885f057
BRCM_PATCHRAM_PLUS_SITE = $(call github,AsteroidOS,brcm-patchram-plus,$(BRCM_PATCHRAM_PLUS_VERSION))
BRCM_PATCHRAM_PLUS_LICENSE = Apache-2.0
BRCM_PATCHRAM_PLUS_LICENSE_FILES = COPYING
BRCM_PATCHRAM_PLUS_AUTORECONF = YES

# C23 changes meaning of empty argument prototypes like int (*)()
# causing build failures, so force gnu99
BRCM_PATCHRAM_PLUS_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=gnu99"

$(eval $(autotools-package))
