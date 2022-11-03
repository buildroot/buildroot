################################################################################
#
# gitlab-runner
#
################################################################################

GITLAB_RUNNER_VERSION = 15.5.0
GITLAB_RUNNER_SITE = https://gitlab.com/gitlab-org/gitlab-runner/-/archive/v$(GITLAB_RUNNER_VERSION)
GITLAB_RUNNER_LICENSE = MIT
GITLAB_RUNNER_LICENSE_FILES = LICENSE

GITLAB_RUNNER_LDFLAGS = \
	-X gitlab.com/gitlab-org/gitlab-runner/common.VERSION=$(GITLAB_RUNNER_VERSION)

# Don't run gitlab runner as root.
define GITLAB_RUNNER_USERS
	gitlab-runner -1 gitlab-runner -1 * /var/run/dbus /bin/false - Gitlab Runner
endef

define GITLAB_RUNNER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/gitlab-runner/S95gitlab-runner \
		$(TARGET_DIR)/etc/init.d/S95gitlab-runner
endef

define GITLAB_RUNNER_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/var/lib/gitlab-runner
	$(INSTALL) -D -m 0644 package/gitlab-runner/gitlab-runner.service \
		$(TARGET_DIR)/usr/lib/systemd/system/gitlab-runner.service
endef

GITLAB_RUNNER_POST_INSTALL_TARGET_HOOKS += GITLAB_RUNNER_INSTALL_CONFIG

$(eval $(golang-package))
