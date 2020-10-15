################################################################################
#
# fonts-droid
#
################################################################################

FONTS_DROID_VERSION = 074990596701553b8b51ff22290453de522f0d15
FONTS_DROID_SITE = https://android.googlesource.com/platform/frameworks/base/+archive/$(FONTS_DROID_VERSION)/data
FONTS_DROID_SOURCE = fonts.tar.gz
FONTS_DROID_LICENSE = Apache-2.0
FONTS_DROID_STRIP_COMPONENTS = 0

# We cannot verify the hash because googlesource.com produces an archive
# with a different hash on every request.
#
# This still issues a warning.
BR_NO_CHECK_HASH_FOR += $(FONTS_DROID_SOURCE)

define FONTS_DROID_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/fonts/droid/
	install -m 0644 $(@D)/NOTICE $(@D)/DroidSansFallback.ttf \
	  $(TARGET_DIR)/usr/share/fonts/droid/
endef

$(eval $(generic-package))
