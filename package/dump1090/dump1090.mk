################################################################################
#
# dump1090
#
################################################################################

DUMP1090_VERSION = 8.2
DUMP1090_SITE = $(call github,flightaware,dump1090,v$(DUMP1090_VERSION))
DUMP1090_LICENSE = GPL-2.0+
DUMP1090_LICENSE_FILES = LICENSE
DUMP1090_DEPENDENCIES = host-pkgconf ncurses
DUMP1090_MAKE_OPTS = BLADERF=no CPUFEATURES=no LIMESDR=no

ifeq ($(BR2_PACKAGE_HACKRF),y)
DUMP1090_DEPENDENCIES += hackrf
DUMP1090_MAKE_OPTS += HACKRF=yes
else
DUMP1090_MAKE_OPTS += HACKRF=no
endif

ifeq ($(BR2_PACKAGE_LIBRTLSDR),y)
DUMP1090_DEPENDENCIES += librtlsdr
DUMP1090_MAKE_OPTS += RTLSDR=yes
else
DUMP1090_MAKE_OPTS += RTLSDR=no
endif

define DUMP1090_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) PREFIX=/usr \
		-C $(@D) $(DUMP1090_MAKE_OPTS)
endef

define DUMP1090_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/dump1090 $(TARGET_DIR)/usr/bin/dump1090
	$(INSTALL) -m 0755 -D $(@D)/view1090 $(TARGET_DIR)/usr/bin/view1090
	$(INSTALL) -d $(TARGET_DIR)/usr/share/dump1090
	cp -r $(@D)/public_html/* $(TARGET_DIR)/usr/share/dump1090
endef

$(eval $(generic-package))
