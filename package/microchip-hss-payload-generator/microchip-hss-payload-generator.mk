################################################################################
#
# microchip-hss-payload-generator
#
################################################################################

HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_VERSION = 2024.06
HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_SITE = $(call github,polarfire-soc,hart-software-services,v$(HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_VERSION))
# Some parts of the repository are under different licenses, but we
# are only building/installing the code in
# tools/hss-payload-generator/.
HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_LICENSE = MIT or GPL-2.0+
HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_LICENSE_FILES = tools/hss-payload-generator/LICENSE.md
HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_DEPENDENCIES = host-elfutils host-libyaml host-openssl

define HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_BUILD_CMDS
	$(MAKE) -C $(@D)/tools/hss-payload-generator \
		HOST_INCLUDES="$(HOST_CPPFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)"
endef

define HOST_MICROCHIP_HSS_PAYLOAD_GENERATOR_INSTALL_CMDS
	$(INSTALL) -D -m 755 \
		$(@D)/tools/hss-payload-generator/hss-payload-generator \
		$(HOST_DIR)/bin/hss-payload-generator
endef

$(eval $(host-generic-package))
