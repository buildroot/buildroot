################################################################################
#
# wolftpm
#
################################################################################

WOLFTPM_VERSION = 2.6.0
WOLFTPM_SITE = $(call github,wolfSSL,wolfTPM,v$(WOLFTPM_VERSION))
WOLFTPM_INSTALL_STAGING = YES
WOLFTPM_LICENSE = GPL-2.0+
WOLFTPM_LICENSE_FILES = LICENSE
WOLFTPM_CONFIG_SCRIPTS = wolftpm-config

# wolfTPM's source code is released without a configure script,
# therefore we need autoreconf
WOLFTPM_AUTORECONF = YES

WOLFTPM_CONF_OPTS = \
	--disable-examples \
	--enable-devtpm

# Fix for missing config.rpath in the codebase
define WOLFTPM_TOUCH_CONFIG_RPATH
	mkdir -p $(@D)/build-aux
	touch $(@D)/build-aux/config.rpath
endef
WOLFTPM_PRE_CONFIGURE_HOOKS += WOLFTPM_TOUCH_CONFIG_RPATH

ifeq ($(BR2_PACKAGE_WOLFTPM_WOLFCRYPT),y)
WOLFTPM_CONF_OPTS += \
	--enable-wolfcrypt \
	--with-wolfcrypt=$(STAGING_DIR)/usr
WOLFTPM_DEPENDENCIES += wolfssl
else
WOLFTPM_CONF_OPTS += --disable-wolfcrypt
endif

ifeq ($(BR2_PACKAGE_WOLFTPM_ST33),y)
WOLFTPM_CONF_OPTS += --enable-st33
else
WOLFTPM_CONF_OPTS += --disable-st33
endif

ifeq ($(BR2_PACKAGE_WOLFTPM_NUVOTON),y)
WOLFTPM_CONF_OPTS += --enable-nuvoton
else
WOLFTPM_CONF_OPTS += --disable-nuvoton
endif

ifeq ($(BR2_PACKAGE_WOLFTPM_DEBUG),y)
WOLFTPM_CONF_OPTS += --enable-debug
else
WOLFTPM_CONF_OPTS += --disable-debug
endif

$(eval $(autotools-package))
