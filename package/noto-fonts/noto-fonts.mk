################################################################################
#
# noto-fonts
#
################################################################################

NOTO_FONTS_SITE = https://noto-website-2.storage.googleapis.com/pkgs
NOTO_FONTS_SOURCE = Noto-unhinted.zip
NOTO_FONTS_TARGET_DIR = $(TARGET_DIR)/usr/share/fonts/noto-fonts
NOTO_FONTS_LICENSE = OFL
NOTO_FONTS_LICENSE_FILES = LICENSE_OFL.txt

define NOTO_FONTS_EXTRACT_CMDS
        $(UNZIP) $(DL_DIR)/$(NOTO_FONTS_SOURCE) -d $(@D)
endef

ifeq ($(BR2_PACKAGE_NOTO_FONTS_ARABIC),y)
define NOTO_FONTS_ARABIC_INSTALL_CMDS
	find $(@D) |grep Arabic | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_BENGALI),y)
define NOTO_FONTS_BENGALI_INSTALL_CMDS
	find $(@D) |grep Bengali | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_CHINESE),y)
define NOTO_FONTS_CHINESE_INSTALL_CMDS
	find $(@D) |grep CJKsc | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_ETHIOPIC),y)
define NOTO_FONTS_ETHIOPIC_INSTALL_CMDS
	find $(@D) |grep Ethiopic | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_GEORGIAN),y)
define NOTO_FONTS_GEORGIAN_INSTALL_CMDS
	find $(@D) |grep Georgian | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_HEBREW),y)
define NOTO_FONTS_HEBREW_INSTALL_CMDS
	find $(@D) |grep Hebrew | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_JAPANESE),y)
define NOTO_FONTS_JAPANESE_INSTALL_CMDS
	find $(@D) |grep CJKjp | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_KOREAN),y)
define NOTO_FONTS_KOREAN_INSTALL_CMDS
	find $(@D) |grep CJKkr | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

ifeq ($(BR2_PACKAGE_NOTO_FONTS_THAI),y)
define NOTO_FONTS_THAI_INSTALL_CMDS
	find $(@D) |grep Thai | grep -v Condensed |grep -v Extra |grep -v Semi | grep -v Light |grep -v Black |grep -v Thin |grep -v Medium | xargs -d "\n" cp -t $(NOTO_FONTS_TARGET_DIR)
endef
endif

define NOTO_FONTS_INSTALL_TARGET_CMDS
	mkdir -p $(NOTO_FONTS_TARGET_DIR)
	$(NOTO_FONTS_ARABIC_INSTALL_CMDS)
	$(NOTO_FONTS_BENGALI_INSTALL_CMDS)
	$(NOTO_FONTS_CHINESE_INSTALL_CMDS)
	$(NOTO_FONTS_ETHIOPIC_INSTALL_CMDS)
	$(NOTO_FONTS_GEORGIAN_INSTALL_CMDS)
	$(NOTO_FONTS_HEBREW_INSTALL_CMDS)
	$(NOTO_FONTS_JAPANESE_INSTALL_CMDS)
	$(NOTO_FONTS_KOREAN_INSTALL_CMDS)
	$(NOTO_FONTS_THAI_INSTALL_CMDS)
endef

$(eval $(generic-package))