################################################################################
#
# panel-mipi-dbi-firmware
#
################################################################################

PANEL_MIPI_DBI_FIRMWARE_VERSION = 1cbd40135a8c7f25d7b444a7fac77fd3c3ad471e
PANEL_MIPI_DBI_FIRMWARE_SITE = https://github.com/notro/panel-mipi-dbi.git
PANEL_MIPI_DBI_FIRMWARE_SITE_METHOD = git
PANEL_MIPI_DBI_FIRMWARE_LICENSE = CC0-1.0
# license info is directly in the only source file
PANEL_MIPI_DBI_FIRMWARE_LICENSE_FILES = mipi-dbi-cmd

PANEL_MIPI_DBI_FIRMWARE_DEPENDENCIES = $(BR2_PYTHON3_HOST_DEPENDENCY)

BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE_BIN = $(addsuffix .bin,$(basename $(notdir $(shell echo $(BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE_SOURCE)))))

define PANEL_MIPI_DBI_FIRMWARE_BUILD_CMDS
	for source in $(shell echo $(BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE_SOURCE)) ; do \
		PATH=$(BR_PATH) $(@D)/mipi-dbi-cmd "$(@D)/$$(basename $${source%.*}).bin" "$${source}" ; \
	done
endef

define PANEL_MIPI_DBI_FIRMWARE_INSTALL_TARGET_CMDS
	for bin in $(shell echo $(BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE_BIN)); do \
		$(INSTALL) -m 0644 -D "$(@D)/$${bin}" "$(TARGET_DIR)/lib/firmware/$${bin}" ; \
	done
endef

# installing firmware requires source, give a clear error message if missing
ifeq ($(BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE)$(call qstrip,$(BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE_SOURCE)),y)
$(error No panel-mipi-dbi firmware source selected, check your BR2_PACKAGE_PANEL_MIPI_DBI_FIRMWARE_SOURCE setting)
endif

$(eval $(generic-package))
