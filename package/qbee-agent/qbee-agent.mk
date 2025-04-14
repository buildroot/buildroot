################################################################################
#
# qbee-agent package
#
################################################################################

# keep QBEE_AGENT_COMMIT_ID in sync when updating
QBEE_AGENT_VERSION = 2024.50
QBEE_AGENT_SITE = $(call github,qbee-io,qbee-agent,$(QBEE_AGENT_VERSION))
QBEE_AGENT_LICENSE = Apache-2.0
QBEE_AGENT_LICENSE_FILES = LICENSE

QBEE_AGENT_COMMIT_ID = 4303465d155f0680968b57fdf4421971786356a4

QBEE_AGENT_GOMOD = go.qbee.io/agent

QBEE_AGENT_LDFLAGS = -s -w \
	-X $(QBEE_AGENT_GOMOD)/app.Version=$(QBEE_AGENT_VERSION) \
	-X $(QBEE_AGENT_GOMOD)/app.Commit=$(QBEE_AGENT_COMMIT_ID)

define QBEE_AGENT_INSTALL_CERT
	$(INSTALL) -D -m 0600 $(@D)/package/share/ssl/ca.cert \
		$(TARGET_DIR)/etc/qbee/ppkeys/ca.cert
endef

QBEE_AGENT_POST_INSTALL_TARGET_HOOKS += QBEE_AGENT_INSTALL_CERT

define QBEE_AGENT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/package/init-scripts/systemd/qbee-agent.service \
		$(TARGET_DIR)/usr/lib/systemd/system/qbee-agent.service
endef

define QBEE_AGENT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(@D)/package/init-scripts/sysvinit/qbee-agent \
		$(TARGET_DIR)/etc/init.d/S99qbee-agent
endef

$(eval $(golang-package))
