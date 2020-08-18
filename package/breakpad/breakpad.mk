################################################################################
#
# breakpad
#
################################################################################
BREAKPAD_VERSION = dea867e76f24e4a68395684b9d1cf24bcef82f20
BREAKPAD_SITE_METHOD = git
BREAKPAD_SITE = git://github.com/google/breakpad
BREAKPAD_INSTALL_STAGING = YES
BREAKPAD_DEPENDENCIES = host-pkgconf host-autoconf gyp gtest protobuf lss

define BREAKPAD_SETUP_SOURCE
        if [ ! -d "$(@D)/src/third_party" ]; then \
		mkdir -p $(@D)/src/third_party; \
        fi; \
	if [ -d "$(STAGING_DIR)/usr/include/third_party/lss" ] && [ ! -e "$(@D)/src/third_party/lss" ] ; then \
		ln -s $(STAGING_DIR)/usr/include/third_party/lss $(@D)/src/third_party/lss; \
	fi
endef
BREAKPAD_PRE_CONFIGURE_HOOKS += BREAKPAD_SETUP_SOURCE

$(eval $(autotools-package))
