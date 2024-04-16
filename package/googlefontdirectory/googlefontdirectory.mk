################################################################################
#
# googlefontdirectory
#
################################################################################

GOOGLEFONTDIRECTORY_VERSION = 2125bc9b447971543caaa132530b828e5e682819
GOOGLEFONTDIRECTORY_SITE = $(call github,google,fonts,$(GOOGLEFONTDIRECTORY_VERSION))

GOOGLEFONTDIRECTORY_FONTS = \
	$(call qstrip,$(BR2_PACKAGE_GOOGLEFONTDIRECTORY_FONTS))

ifneq ($(filter apache/%,$(GOOGLEFONTDIRECTORY_FONTS)),)
GOOGLEFONTDIRECTORY_ALL_LICENSES += Apache-2.0
GOOGLEFONTDIRECTORY_LICENSE_FILES += $(addsuffix /LICENSE.txt,$(filter apache/%,$(GOOGLEFONTDIRECTORY_FONTS)))
endif

ifneq ($(filter ofl/%,$(GOOGLEFONTDIRECTORY_FONTS)),)
GOOGLEFONTDIRECTORY_ALL_LICENSES += OFL-1.1
GOOGLEFONTDIRECTORY_LICENSE_FILES += $(addsuffix /OFL.txt,$(filter ofl/%,$(GOOGLEFONTDIRECTORY_FONTS)))
endif

ifneq ($(filter ufl/%,$(GOOGLEFONTDIRECTORY_FONTS)),)
GOOGLEFONTDIRECTORY_ALL_LICENSES += UFL-1.1
GOOGLEFONTDIRECTORY_LICENSE_FILES += $(addsuffix /LICENCE.txt,$(filter ufl/%,$(GOOGLEFONTDIRECTORY_FONTS)))
endif

GOOGLEFONTDIRECTORY_LICENSE = $(subst $(space),$(comma)$(space),$(GOOGLEFONTDIRECTORY_ALL_LICENSES))

define GOOGLEFONTDIRECTORY_INSTALL_TARGET_CMDS
	$(foreach d,$(GOOGLEFONTDIRECTORY_FONTS), \
		mkdir -p $(TARGET_DIR)/usr/share/fonts/$(notdir $(d))
		$(INSTALL) -m 0644 -t $(TARGET_DIR)/usr/share/fonts/$(notdir $(d)) $(@D)/$(d)/*.ttf
	)
endef

$(eval $(generic-package))
