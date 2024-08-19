################################################################################
#
# nushell
#
################################################################################

NUSHELL_VERSION = 0.96.1
NUSHELL_SITE = $(call github,nushell,nushell,$(NUSHELL_VERSION))
NUSHELL_LICENSE = MIT
NUSHELL_LICENSE_FILES = LICENSE
NUSHELL_DEPENDENCIES = host-pkgconf openssl ncurses

# Add /usr/bin/nu to /etc/shells as in package/bash/bash.mk
define NUSHELL_ADD_NU_TO_SHELLS
	grep -qsE '^/usr/bin/nu$$' $(TARGET_DIR)/etc/shells \
		|| echo "/usr/bin/nu" >> $(TARGET_DIR)/etc/shells
endef
NUSHELL_TARGET_FINALIZE_HOOKS += NUSHELL_ADD_NU_TO_SHELLS

$(eval $(cargo-package))
