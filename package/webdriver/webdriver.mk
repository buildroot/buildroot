################################################################################
#
# webdriver
#
################################################################################

WEBDRIVER_VERSION = 531592b5d1af423fdf7c141c4d49c42aba416bfb
WEBDRIVER_SITE_METHOD = git
WEBDRIVER_SITE = git@github.com:Metrological/webdriver.git
WEBDRIVER_INSTALL_STAGING = YES
WEBDRIVER_DEPENDENCIES = libglib2 wpe json-c jsoncpp
GLIB_INC = $(STAGING_DIR)/usr/include/glib-2.0
GLIB_LIB_INC = $(STAGING_DIR)/usr/lib/glib-2.0/include

define WEBDRIVER_CONFIGURE_CMDS
      (cd $(@D);rm -rf out;./build.sh out rpi release;echo)
endef

define WEBDRIVER_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
	CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
	CXXFLAGS="-I$(GLIB_INC) -I$(GLIB_LIB_INC) $(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib -lWPEWebKit -lWPE -lglib-2.0 -ljson-c -pthread " -C $(@D)/out/rpi/release/; \
	cd $(@D);./copy.sh out rpi release;
endef

define WEBDRIVER_INSTALL_TARGET_CMDS
	cp $(@D)/out/bin/rpi/release/W* $(TARGET_DIR)/usr/bin
	cp $(@D)/out/bin/rpi/release/lib*.so $(TARGET_DIR)/usr/lib
	cp -Rpf $(@D)/web $(TARGET_DIR)/usr/share
endef

define WEBDRIVER_INSTALL_STAGING_CMDS
	$(INSTALL) -D package/webdriver/*.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	cp $(@D)/out/bin/rpi/release/lib*.so $(STAGING_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/
	cp -Rpf $(@D)/src/webdriver_wrapper/*.h $(STAGING_DIR)/usr/include/
endef

$(eval $(cmake-package))
