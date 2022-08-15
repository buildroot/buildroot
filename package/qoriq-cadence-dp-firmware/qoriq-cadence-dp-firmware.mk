################################################################################
#
# qoriq-cadence-dp-firmware
#
################################################################################

QORIQ_CADENCE_DP_FIRMWARE_VERSION = lsdk1909
QORIQ_CADENCE_DP_FIRMWARE_SITE = http://www.nxp.com/lgfiles/sdk/$(QORIQ_CADENCE_DP_FIRMWARE_VERSION)
QORIQ_CADENCE_DP_FIRMWARE_SOURCE = firmware-cadence-$(QORIQ_CADENCE_DP_FIRMWARE_VERSION).bin
QORIQ_CADENCE_DP_FIRMWARE_LICENSE = NXP Semiconductor Software License Agreement
QORIQ_CADENCE_DP_FIRMWARE_LICENSE_FILES = COPYING EULA EULA.txt
QORIQ_CADENCE_DP_FIRMWARE_REDISTRIBUTE = NO
QORIQ_CADENCE_DP_FIRMWARE_INSTALL_IMAGES = YES
QORIQ_CADENCE_DP_FIRMWARE_INSTALL_TARGET = NO

# Helper for self-extracting binaries distributed by NXP.
#
# The --force option makes sure it doesn't fail if the source
# directory already exists. The --auto-accept skips the license check,
# as it is not needed in Buildroot because we have legal-info. Since
# there's a EULA in the binary file, we extract it in this macro, and
# it should therefore be added to the LICENSE_FILES variable of
# packages using this macro. Also, remember to set REDISTRIBUTE to
# "NO". Indeed, this is a legal minefield: the EULA specifies that the
# Board Support Package includes software and hardware (sic!) for
# which a separate license is needed...
#
# $(1): full path to the archive file
#
define QORIQ_CADENCE_DP_FIRMWARE_EXTRACT_HELPER
	awk 'BEGIN      { start = 0; } \
	     /^EOEULA/  { start = 0; } \
	                { if (start) print; } \
	     /<<EOEULA/ { start = 1; }' \
	    $(1) > $(@D)/EULA
	cd $(@D) && sh $(1) --force --auto-accept
	find $(@D)/$(basename $(notdir $(1))) -mindepth 1 -maxdepth 1 -exec mv {} $(@D) \;
	rmdir $(@D)/$(basename $(notdir $(1)))
endef

define QORIQ_CADENCE_DP_FIRMWARE_EXTRACT_CMDS
	$(call QORIQ_CADENCE_DP_FIRMWARE_EXTRACT_HELPER,$(QORIQ_CADENCE_DP_FIRMWARE_DL_DIR)/$(QORIQ_CADENCE_DP_FIRMWARE_SOURCE))
endef

define QORIQ_CADENCE_DP_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/dp/ls1028a-dp-fw.bin $(BINARIES_DIR)/ls1028a-dp-fw.bin
endef

$(eval $(generic-package))
