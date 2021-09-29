################################################################################
#
# polkit-rules-test
#
################################################################################

POLKIT_RULES_TEST_DEPENDENCIES = polkit

define POLKIT_RULES_TEST_USERS
	brtest  -1  brtest  -1   =password  /home/brtest /bin/sh brtest
endef

define POLKIT_RULES_TEST_BUILD_CMDS
	$(INSTALL) -D $(POLKIT_RULES_TEST_PKGDIR)/initd/hello-polkit.c $(@D)/hello-polkit.c
	$(TARGET_CC) $(@D)/hello-polkit.c -o $(@D)/hello-polkit
endef

# Install the rules file to /root. Test_polkit.py first tests that restarting
# timesyncd as a user fails, then moves the rules file and confirmes restarting
# timesyncd as a user succeeds.
define POLKIT_RULES_TEST_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/etc/polkit-1/rules.d
	$(INSTALL) -D $(POLKIT_RULES_TEST_PKGDIR)/systemd/systemd-timesyncd-restart.rules \
		$(TARGET_DIR)/root/systemd-timesyncd-restart.rules
endef

define POLKIT_RULES_TEST_INSTALL_INIT_SYSV
	mkdir -p $(TARGET_DIR)/usr/share/polkit-1/actions/
	$(INSTALL) -D $(@D)/hello-polkit $(TARGET_DIR)/usr/bin/hello-polkit

	$(INSTALL) -D $(POLKIT_RULES_TEST_PKGDIR)/initd/hello-polkit.policy \
		$(TARGET_DIR)/usr/share/polkit-1/actions/hello-polkit.policy

	$(INSTALL) -D $(POLKIT_RULES_TEST_PKGDIR)/initd/hello-polkit.rules \
		$(TARGET_DIR)/root/hello-polkit.rules
endef

$(eval $(generic-package))
