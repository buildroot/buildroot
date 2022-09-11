################################################################################
#
# jquery-ui
#
################################################################################

JQUERY_UI_VERSION = 1.13.1
JQUERY_UI_SITE = https://jqueryui.com/resources/download
JQUERY_UI_SOURCE = jquery-ui-$(JQUERY_UI_VERSION).zip
JQUERY_UI_LICENSE = MIT
JQUERY_UI_LICENSE_FILES = LICENSE.txt

define JQUERY_UI_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(JQUERY_UI_DL_DIR)/$(JQUERY_UI_SOURCE)
	mv $(@D)/jquery-ui-$(JQUERY_UI_VERSION)/* $(@D)
	$(RM) -r $(@D)/jquery-ui-$(JQUERY_UI_VERSION)
endef

define JQUERY_UI_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(@D)/jquery-ui.min.js \
		$(TARGET_DIR)/var/www/jquery-ui.js
	$(INSTALL) -m 0644 -D $(@D)/jquery-ui.min.css \
		$(TARGET_DIR)/var/www/jquery-ui.css
	$(INSTALL) -d $(TARGET_DIR)/var/www/images
	$(INSTALL) -m 0644 -t $(TARGET_DIR)/var/www/images \
		$(@D)/images/*.png
endef

$(eval $(generic-package))
