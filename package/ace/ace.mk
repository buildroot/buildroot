################################################################################
#
# ace
#
################################################################################

ACE_VERSION = 7.0.6
ACE_SOURCE = ACE-$(ACE_VERSION).tar.bz2
ACE_SITE = http://download.dre.vanderbilt.edu/previous_versions
ACE_LICENSE = DOC
ACE_LICENSE_FILES = COPYING
ACE_INSTALL_STAGING = YES
ACE_CPE_ID_VENDOR = vanderbilt
ACE_CPE_ID_PRODUCT = adaptive_communication_environment

# Note: We are excluding examples, apps and tests
# Only compiling ACE libraries (no TAO)
ACE_LIBRARIES = ace ACEXML Kokyu netsvcs protocols/ace

ACE_CPPFLAGS = $(TARGET_CPPFLAGS) -std=c++11

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_101915),y)
ACE_CPPFLAGS += -O0
endif

# ACE uses DEFFLAGS as C++ pre-processor flags, and CCFLAGS as the C++ flags.
# Ace passes the pre-processor flags after the C++ flags, so we pass our
# C++ flags as pre-processor flags, via DEFFLAGS.
ACE_MAKE_OPTS = \
	ACE_ROOT="$(@D)" \
	DEFFLAGS="$(ACE_CPPFLAGS)"

ifeq ($(BR2_PACKAGE_OPENSSL),y)
ACE_LIBRARIES += ace/SSL
ACE_DEPENDENCIES += openssl
define ACE_CONFIGURE_SSL
	echo "ssl = 1" >> $(@D)/include/makeinclude/platform_macros.GNU
endef
endif

# configure the target build
# refer: http://www.dre.vanderbilt.edu/~schmidt/DOC_ROOT/ACE/ACE-INSTALL.html#unix
define ACE_CONFIGURE_CMDS
	# create a config file
	echo ' #include "ace/config-linux.h" ' >> $(@D)/ace/config.h

	# Create platform/compiler-specific Makefile configurations
	$(INSTALL) -m 0644 package/ace/platform_macros.GNU $(@D)/include/makeinclude/

	$(ACE_CONFIGURE_SSL)
endef

define ACE_BUILD_CMDS
	$(foreach lib,$(ACE_LIBRARIES), \
		$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/$(lib) \
			$(ACE_MAKE_OPTS) all
	)
endef

define  ACE_LIBRARIES_INSTALL
	mkdir -p $(1)/usr/share/ace
	$(foreach lib,$(ACE_LIBRARIES), \
		$(MAKE) -C $(@D)/$(lib) $(ACE_MAKE_OPTS) DESTDIR=$(1) install
	)
endef

define  ACE_INSTALL_TARGET_CMDS
	$(call ACE_LIBRARIES_INSTALL,$(TARGET_DIR))
endef

define  ACE_INSTALL_STAGING_CMDS
	$(call ACE_LIBRARIES_INSTALL,$(STAGING_DIR))
endef

$(eval $(generic-package))
