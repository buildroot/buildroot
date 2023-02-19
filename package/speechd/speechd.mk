################################################################################
#
# speechd
#
################################################################################

SPEECHD_VERSION = 0.11.4
SPEECHD_SITE = $(call github,brailcom,speechd,$(SPEECHD_VERSION))
SPEECHD_LICENSE = GPL-2.0+, GPL-3.0+ (buildsystem), LGPL-2.1+
SPEECHD_LICENSE_FILES = COPYING.GPL-2 COPYING.GPL-3 COPYING.LGPL
SPEECHD_INSTALL_STAGING = YES
# speechd source code is released without configure script
SPEECHD_AUTORECONF = YES
SPEECHD_DEPENDENCIES = host-pkgconf dotconf libglib2 libsndfile
SPEECHD_CONF_OPTS = --without-kali

# fix missing config.rpath (needed for autoreconf) in the codebase
define SPEECHD_TOUCH_CONFIG_RPATH
	touch $(@D)/config.rpath
endef
SPEECHD_PRE_CONFIGURE_HOOKS += SPEECHD_TOUCH_CONFIG_RPATH

ifeq ($(BR2_PACKAGE_LIBTOOL),y)
SPEECHD_DEPENDENCIES += libtool
SPEECHD_CONF_OPTS += --with-libltdl
else
SPEECHD_CONF_OPTS += --without-libltdl
endif

define SPEECHD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/speech-dispatcherd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/speech-dispatcherd.service
endef

$(eval $(autotools-package))
