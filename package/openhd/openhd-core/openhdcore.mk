################################################################################
#
# Open.HD Core
#
################################################################################
OPENHD_VERSION = origin/master
OPENHD_SITE = https://github.com/RespawnDespair/openhd-core.git
OPENHD_SITE_METHOD = git
OPENHD_INSTALL_STAGING = YES

OPENHD_DEPENDENCIES = libpcap wiringpi

# Build the core of open.hd
define OPENHD_BUILD_CMDS
     $(MAKE) clean	
     $(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) -C $(@D) all
endef

# After a successfull build, copy all the relevant core files
define OPENHD_INSTALL_TARGET_CMDS
     mkdir -p $(TARGET_DIR)/root/openhd/
     cp -r $(@D)/rx $(TARGET_DIR)/root/openhd/
     cp -r $(@D)/tx_rawsock $(TARGET_DIR)/root/openhd/
     cp -r $(@D)/rx_status $(TARGET_DIR)/root/openhd/

     # Copy the overlay files to the root of the new filesystem
     cp -r $(@D)/overlay $(TARGET_DIR)/
endef

# When using systemd, make sure the openhd service starts
define OPENHD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/openhd/openhd-core/openhd-start.service \
		$(TARGET_DIR)/etc/systemd/system/openhd-start.service
	$(INSTALL) -d $(TARGET_DIR)/etc/systemd/system/sysinit.target.wants
	ln -sf  ../openhd-start.service \
		 $(TARGET_DIR)/etc/systemd/system/sysinit.target.wants/
endef

$(eval $(generic-package))