################################################################################
#
# font-awesome
#
################################################################################

FONT_AWESOME_VERSION = 7.2.0
FONT_AWESOME_SITE = $(call github,FortAwesome,Font-Awesome,$(FONT_AWESOME_VERSION))
FONT_AWESOME_LICENSE = OFL-1.1 (fonts), MIT (code), CC-BY-4.0 (icons)
FONT_AWESOME_LICENSE_FILES = LICENSE.txt
FONT_AWESOME_DIRECTORIES_LIST = css js scss webfonts sprites svgs

define FONT_AWESOME_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/font-awesome/
	$(foreach d,$(FONT_AWESOME_DIRECTORIES_LIST),\
		cp -dpfr $(@D)/$(d) $(TARGET_DIR)/usr/share/font-awesome$(sep))
	mkdir -p $(TARGET_DIR)/usr/share/fonts/
	ln -sf ../font-awesome $(TARGET_DIR)/usr/share/fonts/font-awesome
endef

$(eval $(generic-package))
