#############################################################
#
# gmenu2x
#
#############################################################
GMENU2X_VERSION = d0db254
GMENU2X_SITE = $(call github,opendingux,gmenu2x,$(GMENU2X_VERSION))
GMENU2X_DEPENDENCIES = sdl sdl_ttf sdl_gfx dejavu libpng fonts-droid
GMENU2X_CONF_OPTS = -DBIND_CONSOLE=ON

ifeq ($(BR2_PACKAGE_GMENU2X_SHOW_CLOCK),y)
GMENU2X_CONF_OPTS += -DCLOCK=ON
else
GMENU2X_CONF_OPTS += -DCLOCK=OFF
endif

ifeq ($(BR2_PACKAGE_GMENU2X_CPUFREQ),y)
GMENU2X_CONF_OPTS += -DCPUFREQ=ON
else
GMENU2X_CONF_OPTS += -DCPUFREQ=OFF
endif

ifeq ($(BR2_PACKAGE_LIBOPK),y)
GMENU2X_DEPENDENCIES += libopk
endif

ifeq ($(BR2_PACKAGE_LIBXDGMIME),y)
GMENU2X_DEPENDENCIES += libxdgmime
endif

define GMENU2X_INSTALL_WRAPPER
	mv $(TARGET_DIR)/usr/bin/gmenu2x $(TARGET_DIR)/usr/libexec/gmenu2x
	$(INSTALL) -D -m 0755 board/opendingux/package/gmenu2x/gmenu2x.sh $(TARGET_DIR)/usr/bin/gmenu2x
endef
GMENU2X_POST_INSTALL_TARGET_HOOKS += GMENU2X_INSTALL_WRAPPER

$(eval $(cmake-package))
