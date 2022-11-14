################################################################################
#
# google-breakpad
#
################################################################################

GOOGLE_BREAKPAD_VERSION = c85eb4a59b618f3beaad5445ceb1f865ffa8efdf
GOOGLE_BREAKPAD_SITE = https://chromium.googlesource.com/breakpad/breakpad
GOOGLE_BREAKPAD_SITE_METHOD = git
GOOGLE_BREAKPAD_INSTALL_STAGING = YES
GOOGLE_BREAKPAD_LICENSE = BSD-3-Clause, MIT
GOOGLE_BREAKPAD_LICENSE_FILES = LICENSE
GOOGLE_BREAKPAD_DEPENDENCIES = host-google-breakpad linux-syscall-support

HOST_GOOGLE_BREAKPAD_DEPENDENCIES = host-linux-syscall-support

ifeq ($(BR2_PACKAGE_GOOGLE_BREAKPAD_TOOLS),)
GOOGLE_BREAKPAD_INSTALL_TARGET = NO
endif

# Avoid using depot-tools to download this file.
define HOST_GOOGLE_BREAKPAD_LSS
	$(INSTALL) -D -m 0644 \
		$(HOST_DIR)/include/linux_syscall_support.h \
		$(@D)/src/third_party/lss/linux_syscall_support.h
endef
HOST_GOOGLE_BREAKPAD_PRE_CONFIGURE_HOOKS += HOST_GOOGLE_BREAKPAD_LSS

define GOOGLE_BREAKPAD_LSS
	$(INSTALL) -D -m 0644 \
		$(STAGING_DIR)/usr/include/linux_syscall_support.h \
		$(@D)/src/third_party/lss/linux_syscall_support.h
endef
GOOGLE_BREAKPAD_PRE_CONFIGURE_HOOKS += GOOGLE_BREAKPAD_LSS

define GOOGLE_BREAKPAD_EXTRACT_SYMBOLS
	$(EXTRA_ENV) package/google-breakpad/gen-syms.sh $(STAGING_DIR) \
		$(TARGET_DIR) $(call qstrip,$(BR2_GOOGLE_BREAKPAD_INCLUDE_FILES))
endef
GOOGLE_BREAKPAD_TARGET_FINALIZE_HOOKS += GOOGLE_BREAKPAD_EXTRACT_SYMBOLS

$(eval $(autotools-package))
$(eval $(host-autotools-package))
