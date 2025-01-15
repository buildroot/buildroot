################################################################################
#
# tzdata
#
################################################################################

TZDATA_VERSION = 2024b
TZDATA_SOURCE = tzdata$(TZDATA_VERSION).tar.gz
TZDATA_SITE = https://www.iana.org/time-zones/repository/releases
TZDATA_SELINUX_MODULES = tzdata
TZDATA_STRIP_COMPONENTS = 0
TZDATA_DEPENDENCIES = host-tzdata
HOST_TZDATA_DEPENDENCIES = host-zic
TZDATA_LICENSE = Public domain
TZDATA_LICENSE_FILES = LICENSE

# Take care when re-ordering this list since this might break zone
# dependencies
TZDATA_DEFAULT_ZONELIST = \
	africa antarctica asia australasia europe northamerica \
	southamerica etcetera backward factory

ifeq ($(call qstrip,$(BR2_TARGET_TZ_ZONELIST)),default)
TZDATA_ZONELIST = $(TZDATA_DEFAULT_ZONELIST)
else
TZDATA_ZONELIST = $(call qstrip,$(BR2_TARGET_TZ_ZONELIST))
endif

TZDATA_LOCALTIME = $(call qstrip,$(BR2_TARGET_LOCALTIME))
ifneq ($(TZDATA_LOCALTIME),)
define TZDATA_SET_LOCALTIME
	if [ ! -f $(TARGET_DIR)/usr/share/zoneinfo/$(TZDATA_LOCALTIME) ]; then \
		printf "Error: '%s' is not a valid timezone, check your BR2_TARGET_LOCALTIME setting\n" \
			"$(TZDATA_LOCALTIME)"; \
		exit 1; \
	fi
	ln -sf ../usr/share/zoneinfo/$(TZDATA_LOCALTIME) $(TARGET_DIR)/etc/localtime
	echo "$(TZDATA_LOCALTIME)" >$(TARGET_DIR)/etc/timezone
endef
endif

define TZDATA_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/zoneinfo
	cp -a $(HOST_DIR)/share/zoneinfo/* $(TARGET_DIR)/usr/share/zoneinfo
	cd $(TARGET_DIR)/usr/share/zoneinfo; \
	for zone in posix/*; do \
	    ln -sfn "$${zone}" "$${zone##*/}"; \
	done
	$(TZDATA_SET_LOCALTIME)
endef

define HOST_TZDATA_BUILD_CMDS
	(cd $(@D); \
		for zone in $(TZDATA_ZONELIST); do \
			$(ZIC) -b fat -d _output/posix $$zone || exit 1; \
			$(ZIC) -b fat -d _output/right -L leapseconds $$zone || exit 1; \
		done; \
	)
endef

define HOST_TZDATA_INSTALL_CMDS
	$(INSTALL) -d -m 0755 $(HOST_DIR)/share/zoneinfo
	cp -a $(@D)/_output/* $(@D)/*.tab $(@D)/leap-seconds.list $(HOST_DIR)/share/zoneinfo
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
