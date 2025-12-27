################################################################################
#
# linenoise
#
################################################################################

LINENOISE_VERSION = e26268de5e56bfaad773786471844578fe9f7f4b
LINENOISE_SITE = $(call github,antirez,linenoise,$(LINENOISE_VERSION))
LINENOISE_LICENSE = BSD-2-Clause
LINENOISE_LICENSE_FILES = LICENSE
LINENOISE_CPE_ID_VENDOR = antirez
LINENOISE_CPE_ID_VERSION = 1.0
LINENOISE_INSTALL_STAGING = YES
# Static library only, nothing to install on target
LINENOISE_INSTALL_TARGET = NO

# Fixed in https://github.com/antirez/linenoise/commit/880b94130ffa5f8236392392b447ff2234b11983
LINENOISE_IGNORE_CVES += CVE-2025-9810

define LINENOISE_BUILD_CMDS
	cd $(@D); $(TARGET_CC) $(TARGET_CFLAGS) -c linenoise.c
	cd $(@D); $(TARGET_AR) rcu liblinenoise.a linenoise.o
	cd $(@D); $(TARGET_CC) $(TARGET_LDFLAGS) -o linenoise_example example.c -L. -llinenoise
endef

define LINENOISE_INSTALL_STAGING_CMDS
	$(INSTALL) -m 644 -D $(@D)/linenoise.h \
		$(STAGING_DIR)/usr/include/linenoise.h
	$(INSTALL) -m 644 -D $(@D)/liblinenoise.a \
		$(STAGING_DIR)/usr/lib/liblinenoise.a
	$(INSTALL) -m 755 -D $(@D)/linenoise_example \
		$(STAGING_DIR)/usr/bin/linenoise_example
endef

$(eval $(generic-package))
