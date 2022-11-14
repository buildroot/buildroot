################################################################################
#
# sam-ba
#
################################################################################

SAM_BA_VERSION = 3.7
SAM_BA_SITE = https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/SoftwareLibraries/Firmware
SAM_BA_SOURCE = sam-ba_v$(SAM_BA_VERSION)-linux_x86_64.tar.gz
SAM_BA_LICENSE = GPLv2
SAM_BA_LICENSE_FILES = LICENSE.txt

# Since it's a prebuilt application and it does not conform to the
# usual Unix hierarchy, we install it in $(HOST_DIR)/opt/sam-ba and
# then create a symbolic link from $(HOST_DIR)/bin to the
# application binary, for easier usage.

define HOST_SAM_BA_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/opt/sam-ba/
	cp -a $(@D)/* $(HOST_DIR)/opt/sam-ba/
	mkdir -p $(HOST_DIR)/bin/
	ln -sf ../opt/sam-ba/sam-ba $(HOST_DIR)/bin/sam-ba
endef

$(eval $(host-generic-package))
