################################################################################
#
# powertop
#
################################################################################

POWERTOP_VERSION = 2.15
POWERTOP_SITE = $(call github,fenrus75,powertop,v$(POWERTOP_VERSION))
POWERTOP_LICENSE = GPL-2.0
POWERTOP_LICENSE_FILES = COPYING

POWERTOP_DEPENDENCIES = \
	host-autoconf-archive \
	host-pkgconf \
	libnl \
	ncurses \
	$(if $(BR2_PACKAGE_PCIUTILS),pciutils) \
	$(TARGET_NLS_DEPENDENCIES)

# 0001-add-disable-stack-protector-option.patch
POWERTOP_AUTOPOINT = YES
POWERTOP_AUTORECONF = YES
POWERTOP_AUTORECONF_OPTS = --include=$(HOST_DIR)/share/autoconf-archive

POWERTOP_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)
POWERTOP_CONF_OPTS = --disable-stack-protector

# fix missing config.rpath (needed for autoreconf) in the codebase
define POWERTOP_TOUCH_CONFIG_RPATH
	touch $(@D)/config.rpath
endef
POWERTOP_PRE_CONFIGURE_HOOKS += POWERTOP_TOUCH_CONFIG_RPATH

# Help powertop at finding the right ncurses library depending on
# which one is available.
ifeq ($(BR2_PACKAGE_NCURSES_WCHAR),y)
POWERTOP_CONF_ENV += ac_cv_search_delwin="-lncursesw"
else
POWERTOP_CONF_ENV += ac_cv_search_delwin="-lncurses"
endif

$(eval $(autotools-package))
