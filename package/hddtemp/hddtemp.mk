################################################################################
#
# hddtemp
#
################################################################################

HDDTEMP_VERSION = 0.4.3
HDDTEMP_SITE = $(call github,vitlav,hddtemp,v$(HDDTEMP_VERSION))
HDDTEMP_LICENSE = GPLv2
HDDTEMP_LICENSE_FILES = GPL-2

# Fetched from Github with no configure script
HDDTEMP_AUTORECONF = YES
HDDTEMP_AUTOPOINT = YES

HDDTEMP_DB_PATH = /usr/share/misc/hddtemp.db
HDDTEMP_CONF_OPTS = --with-db-path=$(HDDTEMP_DB_PATH)
HDDTEMP_CONF_ENV = LIBS="$(HDDTEMP_LIBS) $(TARGET_NLS_LIBS)"
HDDTEMP_DEPENDENCIES += $(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
HDDTEMP_DEPENDENCIES += libexecinfo
HDDTEMP_LIBS += -lexecinfo
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
HDDTEMP_DEPENDENCIES += libiconv
HDDTEMP_LIBS += -liconv
endif

define HDDTEMP_INSTALL_HDDTEMP_DB
	$(INSTALL) -D $(@D)/data/hddtemp.db $(TARGET_DIR)$(HDDTEMP_DB_PATH)
endef
HDDTEMP_POST_INSTALL_TARGET_HOOKS += HDDTEMP_INSTALL_HDDTEMP_DB

$(eval $(autotools-package))
