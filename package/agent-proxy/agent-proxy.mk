################################################################################
#
# agent-proxy
#
################################################################################

AGENT_PROXY_VERSION = 1.97
AGENT_PROXY_SITE = https://git.kernel.org/pub/scm/utils/kernel/kgdb/agent-proxy.git/snapshot
AGENT_PROXY_LICENSE = GPL-2.0
AGENT_PROXY_LICENSE_FILES = COPYING

define HOST_AGENT_PROXY_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define HOST_AGENT_PROXY_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/agent-proxy $(HOST_DIR)/bin/agent-proxy
endef

$(eval $(host-generic-package))
