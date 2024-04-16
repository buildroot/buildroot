################################################################################
#
# net-tools
#
################################################################################

NET_TOOLS_VERSION = 2.10
NET_TOOLS_SOURCE = net-tools-$(NET_TOOLS_VERSION).tar.xz
NET_TOOLS_SITE = http://downloads.sourceforge.net/project/net-tools
NET_TOOLS_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)
NET_TOOLS_LICENSE = GPL-2.0+
NET_TOOLS_LICENSE_FILES = COPYING
NET_TOOLS_CPE_ID_VALID = YES

define NET_TOOLS_CONFIGURE_CMDS
	(cd $(@D); yes "" | ./configure.sh config.in )
endef

# Enable I18N when appropiate
ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
define NET_TOOLS_ENABLE_I18N
	$(SED) 's:I18N 0:I18N 1:' $(@D)/config.h
endef
endif

# Enable IPv6
define NET_TOOLS_ENABLE_IPV6
	$(SED) 's:_AFINET6 0:_AFINET6 1:' $(@D)/config.h
endef

NET_TOOLS_POST_CONFIGURE_HOOKS += NET_TOOLS_ENABLE_I18N NET_TOOLS_ENABLE_IPV6

define NET_TOOLS_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) \
		LDFLAGS="$(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)" \
		$(MAKE) -C $(@D)
endef

# ifconfig & route reside in /sbin for busybox, so ensure we don't end
# up with two versions of those.
define NET_TOOLS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
	mv -f $(TARGET_DIR)/bin/ifconfig $(TARGET_DIR)/sbin/ifconfig
	mv -f $(TARGET_DIR)/bin/route $(TARGET_DIR)/sbin/route
endef

$(eval $(generic-package))
