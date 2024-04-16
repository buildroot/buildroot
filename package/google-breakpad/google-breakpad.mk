################################################################################
#
# google-breakpad
#
################################################################################

GOOGLE_BREAKPAD_VERSION = f49c2f1a2023da0cb055874fba050563dfea57db
GOOGLE_BREAKPAD_SITE = https://chromium.googlesource.com/breakpad/breakpad
GOOGLE_BREAKPAD_SITE_METHOD = git
GOOGLE_BREAKPAD_INSTALL_STAGING = YES
# APSL-2.0, BSD-4-Clause, Apache-2.0, BSD-2-Clause not listed, only
# used for Mac code, GPL-2.0 not listed, only used for autotools code
GOOGLE_BREAKPAD_LICENSE = \
	BSD-3-Clause, \
	Unicode-DFS-2015 (UTF code), \
	MIT (src/common/linux/breakpad_getcontext.S), \
	curl (src/third_party/curl/), \
	ClArtistic (src/third_party/libdisasm)
GOOGLE_BREAKPAD_LICENSE_FILES = LICENSE
# Needed because the configure/Makefile.in provided in the Git
# repository is out of date, and links with -lzstd even if
# --disable-zstd is passed
GOOGLE_BREAKPAD_AUTORECONF = YES
GOOGLE_BREAKPAD_DEPENDENCIES = host-google-breakpad linux-syscall-support zlib
GOOGLE_BREAKPAD_CONF_OPTS = --disable-zstd

HOST_GOOGLE_BREAKPAD_DEPENDENCIES = host-linux-syscall-support host-zlib
HOST_GOOGLE_BREAKPAD_CONF_OPTS = --disable-zstd

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
