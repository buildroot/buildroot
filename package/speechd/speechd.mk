################################################################################
#
# speechd
#
################################################################################

SPEECHD_VERSION = 0.11.5
SPEECHD_SITE = $(call github,brailcom,speechd,$(SPEECHD_VERSION))
SPEECHD_LICENSE = GPL-2.0+, GPL-3.0+ (buildsystem), LGPL-2.1+
SPEECHD_LICENSE_FILES = COPYING.GPL-2 COPYING.GPL-3 COPYING.LGPL
SPEECHD_CPE_ID_VENDOR = brailcom
SPEECHD_INSTALL_STAGING = YES
# speechd source code is released without configure script
SPEECHD_AUTORECONF = YES
SPEECHD_AUTOPOINT = YES
SPEECHD_DEPENDENCIES = \
	host-pkgconf dotconf libglib2 libsndfile $(TARGET_NLS_DEPENDENCIES)
SPEECHD_CONF_ENV = \
	ac_cv_prog_HELP2MAN="" \
	LIBS=$(TARGET_NLS_LIBS)
SPEECHD_CONF_OPTS = \
	--disable-python \
	--without-espeak \
	--without-espeak-ng \
	--without-flite \
	--without-ibmtts \
	--without-voxin \
	--without-ivona \
	--without-pico \
	--without-baratinoo \
	--without-kali \
	--without-pulse \
	--without-libao \
	--without-alsa \
	--with-oss \
	--without-nas

# fix missing config.rpath (needed for autoreconf) in the codebase
define SPEECHD_TOUCH_CONFIG_RPATH
	touch $(@D)/config.rpath
endef
SPEECHD_PRE_CONFIGURE_HOOKS += SPEECHD_TOUCH_CONFIG_RPATH

ifeq ($(BR2_PACKAGE_LIBTOOL),y)
SPEECHD_DEPENDENCIES += libtool
SPEECHD_CONF_OPTS += --enable-ltdl
else
SPEECHD_CONF_OPTS += --disable-ltdl
endif

define SPEECHD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/speech-dispatcherd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/speech-dispatcherd.service
endef

$(eval $(autotools-package))
