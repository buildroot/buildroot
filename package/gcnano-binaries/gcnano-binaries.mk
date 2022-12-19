################################################################################
#
# gcnano-binaries
#
################################################################################

GCNANO_BINARIES_LIB_VERSION = 6.4.9
GCNANO_BINARIES_DRIVER_VERSION = $(GCNANO_BINARIES_LIB_VERSION)
GCNANO_BINARIES_USERLAND_VERSION = $(GCNANO_BINARIES_LIB_VERSION)-20221206
GCNANO_BINARIES_VERSION = 0ac1a89d7a59d040a69745a85f0da7e98644cc4b
GCNANO_BINARIES_SITE = $(call github,STMicroelectronics,gcnano-binaries,$(GCNANO_BINARIES_VERSION))

GCNANO_BINARIES_LICENSE = MIT, Vivante End User Software License Terms
GCNANO_BINARIES_LICENSE_FILES = EULA
GCNANO_BINARIES_REDISTRIBUTE = NO

GCNANO_BINARIES_DEPENDENCIES = linux wayland libdrm

GCNANO_BINARIES_INSTALL_STAGING = YES

GCNANO_BINARIES_PROVIDES = libegl libgles libgbm

# The Github repository doesn't contain the source code as-is: it
# contains a tarball with the kernel driver source code, and a
# self-extractible binary for the user-space parts. So we extract both
# below, and also extract the EULA text from the self-extractible binary
define GCNANO_BINARIES_EXTRACT_HELPER
	tar --strip-components=1 -xJf $(@D)/gcnano-driver-$(GCNANO_BINARIES_DRIVER_VERSION).tar.xz -C $(@D)
	awk 'BEGIN      { start = 0; } \
		/^EOEULA/  { start = 0; } \
			{ if (start) print; } \
		/<<EOEULA/ { start = 1; }' \
		$(@D)/gcnano-userland-multi-$(GCNANO_BINARIES_USERLAND_VERSION).bin > $(@D)/EULA
	cd $(@D) && sh gcnano-userland-multi-$(GCNANO_BINARIES_USERLAND_VERSION).bin --auto-accept
endef

GCNANO_BINARIES_POST_EXTRACT_HOOKS += GCNANO_BINARIES_EXTRACT_HELPER

GCNANO_BINARIES_MODULE_MAKE_OPTS = \
	KERNEL_DIR=$(LINUX_DIR) \
	SOC_PLATFORM=st-mp1 \
	AQROOT=$(@D) \
	DEBUG=0

GCNANO_BINARIES_USERLAND_SUBDIR = gcnano-userland-multi-$(GCNANO_BINARIES_USERLAND_VERSION)

define GCNANO_BINARIES_INSTALL
	cd $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/release/drivers/ ; \
	find . -type f -exec $(INSTALL) -D -m 0755 {} $(1)/usr/lib/{} \; ; \
	for sharelib in *.so.*; do \
		dev_lib_name=`echo $${sharelib} | awk -F'.so' '{print $$1}'`.so ; \
		link_name=`$(TARGET_OBJDUMP) -x $${sharelib} 2>/dev/null | grep SONAME | sed 's/.* //'` ; \
		ln -sf $${sharelib} $(1)/usr/lib/$${dev_lib_name} ; \
		ln -sf $${sharelib} $(1)/usr/lib/$${link_name} ; \
	done
	mkdir -p $(1)/usr/include
	cp -a $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/release/include/* $(1)/usr/include/
	mkdir -p $(1)/usr/lib/pkgconfig/
	cp -a $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/pkgconfig/*  $(1)/usr/lib/pkgconfig/
endef

define GCNANO_BINARIES_INSTALL_TARGET_CMDS
	$(call GCNANO_BINARIES_INSTALL,$(TARGET_DIR))
endef

define GCNANO_BINARIES_INSTALL_STAGING_CMDS
	$(call GCNANO_BINARIES_INSTALL,$(STAGING_DIR))
endef

$(eval $(kernel-module))
$(eval $(generic-package))
