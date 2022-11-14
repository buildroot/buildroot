################################################################################
#
# sftp
#
################################################################################

SFTP_VERSION = 1.0
SFTP_SOURCE = ssh-test-$(SFTP_VERSION).tar.xz
SFTP_SITE = sftp://localhost/$(SSHD_TEST_DIR)
SFTP_DL_OPTS = \
	-P $(SSHD_PORT_NUMBER) \
	-i $(SSH_IDENTITY) \
	-o "UserKnownHostsFile=/dev/null" \
	-o "StrictHostKeyChecking=no" \
	-o "CheckHostIP=no"

$(eval $(generic-package))
