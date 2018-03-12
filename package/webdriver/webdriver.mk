################################################################################
#
# webdriver
#
################################################################################

WEBDRIVER_VERSION = 5668e536fcf054d9b064a2b7f77a47f40d38b442
WEBDRIVER_SITE_METHOD = git
WEBDRIVER_SITE = git@github.com:Metrological/webdriver.git
WEBDRIVER_INSTALL_STAGING = YES
WEBDRIVER_DEPENDENCIES = host-gyp libglib2 wpewebkit json-c libcurl

GLIB_INC = $(STAGING_DIR)/usr/include/glib-2.0
GLIB_LIB_INC = $(STAGING_DIR)/usr/lib/glib-2.0/include
WD_PLATFORM_NAME = wpe

export PYTHON=$(HOST_DIR)/usr/bin/python2
export GYP=$(HOST_DIR)/usr/bin/gyp

define WEBDRIVER_CONFIGURE_CMDS
      cd $(@D);rm -rf out;./build_wpe.sh out release
endef

define WEBDRIVER_BUILD_CMDS
	export WPE_TARGET_DIR="$(TARGET_DIR)";\
	export WPE_STAGING_DIR="$(STAGING_DIR)";\
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
	CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
	CXXFLAGS="-I$(GLIB_INC) -I$(GLIB_LIB_INC) $(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib -lWPEWebKit -lglib-2.0 -ljson-c -lcurl -pthread " -C $(@D)/out/$(WD_PLATFORM_NAME)/release/; \
	cd $(@D);./copy.sh out release;
endef

define WEBDRIVER_INSTALL_TARGET_CMDS
	cp $(@D)/out/bin/$(WD_PLATFORM_NAME)/release/W* $(TARGET_DIR)/usr/bin
	cp $(@D)/out/bin/$(WD_PLATFORM_NAME)/release/lib*.so $(TARGET_DIR)/usr/lib
	cp -Rpf $(@D)/web $(TARGET_DIR)/usr/share
endef

define WEBDRIVER_INSTALL_STAGING_CMDS
	$(INSTALL) -D package/webdriver/*.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	cp $(@D)/out/bin/$(WD_PLATFORM_NAME)/release/lib*.so $(STAGING_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/
	cp -Rpf $(@D)/src/webdriver_wrapper/*.h $(STAGING_DIR)/usr/include/
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
