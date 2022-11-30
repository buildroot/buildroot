################################################################################
#
# scp
#
################################################################################

SCP_VERSION = 1.0
SCP_SOURCE = ssh-test-$(SCP_VERSION).tar.xz
SCP_SITE = scp://localhost:$(SSHD_TEST_DIR)
SCP_DL_OPTS = \
	-P $(SSHD_PORT_NUMBER) \
	-i $(SSH_IDENTITY) \
	-o "UserKnownHostsFile=/dev/null" \
	-o "StrictHostKeyChecking=no" \
	-o "CheckHostIP=no"

$(eval $(generic-package))
