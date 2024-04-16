################################################################################
#
# nushell
#
################################################################################

NUSHELL_VERSION = 0.85.0
NUSHELL_SITE = $(call github,nushell,nushell,$(NUSHELL_VERSION))
NUSHELL_LICENSE = MIT
NUSHELL_LICENSE_FILES = LICENSE
NUSHELL_DEPENDENCIES = host-pkgconf openssl ncurses

# 0001-uucore-add-support-for-sparc64.patch
define NUSHELL_PATCH_CHECKSUM_FILE
	$(SED) 's/b0390ae7bca8b31f0db289a5d064bba36d45e4d137674e9df2c6ab6256f926f4/f8ce2ad571e1482f6833cb147eafeb724776e7887ebabf339a5f3e79860583cb/' \
		$(@D)/VENDOR/uucore/.cargo-checksum.json
endef
NUSHELL_POST_PATCH_HOOKS += NUSHELL_PATCH_CHECKSUM_FILE

# Add /usr/bin/nu to /etc/shells as in package/bash/bash.mk
define NUSHELL_ADD_NU_TO_SHELLS
	grep -qsE '^/usr/bin/nu$$' $(TARGET_DIR)/etc/shells \
		|| echo "/usr/bin/nu" >> $(TARGET_DIR)/etc/shells
endef
NUSHELL_TARGET_FINALIZE_HOOKS += NUSHELL_ADD_NU_TO_SHELLS

$(eval $(cargo-package))
