################################################################################
#
# playready
#
################################################################################

PLAYREADY_VERSION = 5af745dd2a8312a34081150c8b374684799fc1c9
PLAYREADY_SITE = git@github.com:Metrological/playready.git
PLAYREADY_SITE_METHOD = git
PLAYREADY_LICENSE = PROPRIETARY
PLAYREADY_DEPENDENCIES = 
PLAYREADY_INSTALL_STAGING = YES
PLAYREADY_INSTALL_TARGET = YES
PLAYREADY_SUBDIR = src

PLAYREADY_CONF_OPTS = \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -std=c99 -D_GNU_SOURCE"

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY), y)
    PLAYREADY_CONF_OPTS += -DPLAYREADY_USE_PROVISION=ON
    PLAYREADY_DEPENDENCIES += wpeframework
else ifeq ($(BR2_PACKAGE_CPPSDK),y)
    # Deprecated support
    ifeq ($(BR2_PACKAGE_LIBPROVISION),y)
        PLAYREADY_CONF_OPTS += -DPLAYREADY_USE_PROVISION=ON
        PLAYREADY_DEPENDENCIES += libprovision
    endif
endif

define PLAYREADY_INSTALL_STAGING_PC
	$(INSTALL) -D package/playready/playready.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/playready.pc
endef

define PLAYREADY_INSTALL_TARGET_ETC_PLAYREADY
	if [ -f package/playready/bgroupcert.dat ]; then \
		$(INSTALL) -D -m 0644 package/playready/bgroupcert.dat $(TARGET_DIR)/etc/playready/; \
	fi
	if [ -f package/playready/zgpriv.dat ]; then \
		$(INSTALL) -D -m 0644 package/playready/zgpriv.dat $(TARGET_DIR)/etc/playready/; \
	fi
	ln -sf /tmp $(TARGET_DIR)/etc/playready/storage
endef

PLAYREADY_POST_INSTALL_STAGING_HOOKS += PLAYREADY_INSTALL_STAGING_PC
PLAYREADY_POST_INSTALL_TARGET_HOOKS += PLAYREADY_INSTALL_TARGET_ETC_PLAYREADY

$(eval $(cmake-package))
