################################################################################
#
# webdriver
#
################################################################################

WEBDRIVER_VERSION = 1f0285ad84f440142a1fde7d070aa8736adebced
#cbdbdb409aa4e33b910ff8dadd936486e65aa821
WEBDRIVER_SITE_METHOD = git
WEBDRIVER_SITE = git@github.com:Metrological/webdriver.git
WEBDRIVER_INSTALL_STAGING = YES
WEBDRIVER_DEPENDENCIES = libglib2 wpe
GLIB_INC = $(STAGING_DIR)/usr/include/glib-2.0
GLIB_LIB_INC = $(STAGING_DIR)/usr/lib/glib-2.0/include

define WEBDRIVER_CONFIGURE_CMDS
      (cd $(@D);rm -rf out;./build.sh out rpi release;echo)
endef

define WEBDRIVER_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
	CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
	CXXFLAGS="-I$(GLIB_INC) -I$(GLIB_LIB_INC) $(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib -lWPEWebKit -lWPE -lglib-2.0 -pthread " -C $(@D)/out/rpi/release/; \
	cd $(@D);./copy.sh out rpi release;
endef

define WEBDRIVER_INSTALL_TARGET_CMDS
	cp $(@D)/out/bin/rpi/release/WebDriver $(TARGET_DIR)/usr/bin 
	cp $(@D)/out/bin/rpi/release/lib*.so $(TARGET_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/
	cp -Rpf $(@D)/src/webdriver_wrapper/*.h $(STAGING_DIR)/usr/include/
endef

define WEBDRIVER_INSTALL_STAGING_CMDS
  $(INSTALL) -D package/webdriver/*.pc $(STAGING_DIR)/usr/lib/pkgconfig/
  cp $(@D)/out/bin/rpi/release/lib*.so $(STAGING_DIR)/usr/lib
  mkdir -p $(STAGING_DIR)/usr/include/
  cp -Rpf $(@D)/src/webdriver_wrapper/*.h $(STAGING_DIR)/usr/include/
endef

$(eval $(cmake-package))
