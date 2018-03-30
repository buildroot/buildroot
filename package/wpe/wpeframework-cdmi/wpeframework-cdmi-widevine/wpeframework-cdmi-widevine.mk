################################################################################
#
# wpeframework-cdmi-widevine
#
################################################################################

WPEFRAMEWORK_CDMI_WIDEVINE_VERSION = 26a669de86184afb22e33cbc1fffa3f8b373b5b2
WPEFRAMEWORK_CDMI_WIDEVINE_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_SITE = git@github.com:WebPlatformForEmbedded/OCDM-Widevine.git
WPEFRAMEWORK_CDMI_WIDEVINE_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_WIDEVINE_DEPENDENCIES = wpeframework widevine


define WPEFRAMEWORK_CDMI_WIDEVINE_POST_INSTALLATION
	$(INSTALL) -m 755 -d $(TARGET_DIR)/etc/WideVine
	$(INSTALL) -D -m 755 $(@D)/tools/keybox/testkeybox.bin $(TARGET_DIR)/etc/WideVine/keybox.bin
endef

WPEFRAMEWORK_CDMI_WIDEVINE_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_CDMI_WIDEVINE_POST_INSTALLATION

$(eval $(cmake-package))
