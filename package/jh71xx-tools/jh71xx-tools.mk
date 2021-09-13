################################################################################
#
# jh71xx-tools
#
################################################################################

JH71XX_TOOLS_VERSION = 7a29f4b9d2355aa39afa8680680909bb74e4991d
JH71XX_TOOLS_SITE = $(call github,kprasadvnsi,JH71xx-tools,$(JH71XX_TOOLS_VERSION))
JH71XX_TOOLS_LICENSE = MIT
JH71XX_TOOLS_LICENSE_FILES = LICENSE

define HOST_JH71XX_TOOLS_BUILD_CMDS
	$(HOSTCC) -o $(@D)/jh7100-recover $(@D)/jh7100-recover.c
endef

define HOST_JH71XX_TOOLS_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/jh7100-recover $(HOST_DIR)/bin/jh7100-recover
endef

$(eval $(host-generic-package))
