################################################################################
#
# opendoas
#
################################################################################

OPENDOAS_VERSION = 6.8.2
OPENDOAS_SITE = $(call github,Duncaen,OpenDoas,v$(OPENDOAS_VERSION))
OPENDOAS_LICENSE = ISC
OPENDOAS_LICENSE_FILES = LICENSE

OPENDOAS_DEPENDENCIES = host-bison

# Those options looks like autotools ones, but this package has a
# handwritten "configure" script that mimic a subset of autotools.
# This is why this package uses the generic-package infra. See:
# https://github.com/Duncaen/OpenDoas/blob/v6.8.2/configure
OPENDOAS_CONF_OPTS = \
	--target=$(GNU_TARGET_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--with-shadow

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
OPENDOAS_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
define OPENDOAS_INSTALL_PAM_CONF
	$(INSTALL) -D -m 0644 $(@D)/pam.d__doas__linux $(TARGET_DIR)/etc/pam.d/doas
endef

OPENDOAS_DEPENDENCIES += linux-pam
OPENDOAS_CONF_OPTS += --with-pam
else
OPENDOAS_CONF_OPTS += --without-pam
endif

define OPENDOAS_CONFIGURE_CMDS
	(cd $(@D) && \
	$(TARGET_CONFIGURE_OPTS) ./configure $(OPENDOAS_CONF_OPTS))
endef

define OPENDOAS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CC="$(TARGET_CC)" \
		YACC="$(HOST_DIR)/bin/bison -y"
endef

define OPENDOAS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/doas $(TARGET_DIR)/usr/bin/doas
	$(OPENDOAS_INSTALL_PAM_CONF)
endef

# NOTE: Even though this package has a "configure" script, it is not
# generated using autotools, so we have to use the generic package
# infrastructure.
$(eval $(generic-package))
