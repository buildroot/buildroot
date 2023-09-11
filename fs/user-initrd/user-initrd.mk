################################################################################
#
# Build customizable user initrd
#
################################################################################

LD_LINUX = $(STAGING_DIR)/usr/lib/ld-linux-x86-64.so.2
TARGET_LIB_DIR = $(TARGET_DIR)/lib
TARGET_BIN_DIR = $(TARGET_DIR)/bin
OUTPUT_DIR = $(@D)/skel
DEPS_FILE = $(@D)/deps.txt

include fs/user-initrd/user-initrd-packages.mk
include fs/user-initrd/user-initrd-libc.mk

define USER_INITRD_EXTRACT_CMDS
	cp -r $(USER_INITRD_PKGDIR)/skel $(@D)
	find $(@D)/skel -type f -name .placeholder -exec rm {} \;
endef

define USER_INITRD_BUILD_CMDS
	$(USER_INITRD_BUILD_HOOKS)
	$(USER_INITRD_PKGDIR)/deps.pl \
		--ld-linux=$(LD_LINUX) \
		--lib-dir=$(TARGET_LIB_DIR) \
		--bin-dir=$(OUTPUT_DIR)/bin \
		--output-dir=$(OUTPUT_DIR) \
		--deps-file=$(DEPS_FILE) \
		--src-rootfs=$(TARGET_DIR) \
		--host-dir=$(HOST_DIR)/$(GNU_TARGET_NAME)
	rm -rf $(OUTPUT_DIR)/usr/share/{doc,info,man}
	rm -rf $(OUTPUT_DIR)/usr/include
	find $(OUTPUT_DIR)/bin/ $(OUTPUT_DIR)/lib/ -type f -exec strip -d {} \;
	cd $(OUTPUT_DIR) && find ./ -mindepth 1 | cpio -o  -H newc | gzip -9 -c > ../initrd.gz
endef

define USER_INITRD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0444 $(@D)/initrd.gz $(BINARIES_DIR)/initrd.gz
endef

$(eval $(generic-package))
