################################################################################
#
# rbuscore
#
################################################################################

RBUS_CORE_VERSION = 1ab589a0aaa70b10afb21fa135683fcbbb704964
RBUS_CORE_SITE_METHOD = git
RBUS_CORE_SITE = https://code.rdkcentral.com/r/components/opensource/rbuscore
RBUS_CORE_INSTALL_STAGING = YES
RBUS_CORE_AUTORECONF = YES
RBUS_CORE_DEPENDENCIES = rtmessage msgpack-c

RBUS_CORE_CONF_OPTS = -DRBUS_ALWAYS_ON=ON

define RBUS_CORE_INSTALL_INIT_SYSV
    $(INSTALL) -m 0755 -D $(RBUS_CORE_PKGDIR)S30rbuscore \
        $(TARGET_DIR)/etc/init.d/S30rbuscore
endef

$(eval $(cmake-package))
