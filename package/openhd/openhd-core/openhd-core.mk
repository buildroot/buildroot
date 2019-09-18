################################################################################
#
# Open.HD Core
#
################################################################################

OPENHD_CORE_VERSION = origin/master
OPENHD_CORE_SITE = https://github.com/RespawnDespair/wifibroadcast-base.git
OPENHD_CORE_SITE_METHOD = git
OPENHD_CORE_INSTALL_STAGING = YES
OPENHD_CORE_GIT_SUBMODULES = YES

OPENHD_CORE_DEPENDENCIES = libpcap wiringnp

# Build the core of open.hd
define OPENHD_CORE_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) -C $(@D) rx tx_rawsock rx_status
endef

# After a successfull build, copy all the relevant core files
define OPENHD_CORE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/root/openhd/
	cp -r $(@D)/rx $(TARGET_DIR)/root/openhd/
	cp -r $(@D)/tx_rawsock $(TARGET_DIR)/root/openhd/
	cp -r $(@D)/rx_status $(TARGET_DIR)/root/openhd/

	# Copy the overlay files to the root of the new filesystem
	#cp -r $(@D)/overlay $(TARGET_DIR)/
endef

# When using systemd, make sure the openhd service starts
define OPENHD_CORE_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/openhd-start.service \
		$(TARGET_DIR)/etc/systemd/system/openhd-start.service
	$(INSTALL) -d $(TARGET_DIR)/etc/systemd/system/sysinit.target.wants
	ln -sf  ../openhd-start.service \
		 $(TARGET_DIR)/etc/systemd/system/sysinit.target.wants/
endef

$(eval $(generic-package))
