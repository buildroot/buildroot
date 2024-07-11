################################################################################
#
# gcnano-binaries
#
################################################################################

GCNANO_BINARIES_LIB_VERSION = 6.4.15
GCNANO_BINARIES_DRIVER_VERSION = $(GCNANO_BINARIES_LIB_VERSION)

GCNANO_BINARIES_SITE = $(call github,STMicroelectronics,gcnano-binaries,$(GCNANO_BINARIES_VERSION))
GCNANO_BINARIES_VERSION = bbaae49a0e4859ed53f898a250269c8a237261bc
ifeq ($(BR2_arm),y)
GCNANO_BINARIES_USERLAND_VERSION = stm32mp1-$(GCNANO_BINARIES_LIB_VERSION)-20240206
GCNANO_BINARIES_ARCH_TYPE = arm
GCNANO_BINARIES_SOC_PLATFORM = st-mp1
else
GCNANO_BINARIES_USERLAND_VERSION = stm32mp2-$(GCNANO_BINARIES_LIB_VERSION)-20240517
GCNANO_BINARIES_ARCH_TYPE = arm64
GCNANO_BINARIES_SOC_PLATFORM = st-mp2
endif

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
	awk 'BEGIN      { start = 0; } \
		/^EOEULA/  { start = 0; } \
			{ if (start) print; } \
		/<<EOEULA/ { start = 1; }' \
		$(@D)/gcnano-userland-multi-$(GCNANO_BINARIES_USERLAND_VERSION).bin > $(@D)/EULA
	cd $(@D) && sh gcnano-userland-multi-$(GCNANO_BINARIES_USERLAND_VERSION).bin --auto-accept
endef

GCNANO_BINARIES_POST_EXTRACT_HOOKS += GCNANO_BINARIES_EXTRACT_HELPER

GCNANO_BINARIES_MODULE_SUBDIRS = gcnano-driver-stm32mp

GCNANO_BINARIES_MODULE_MAKE_OPTS = \
	ARCH_TYPE=$(GCNANO_BINARIES_ARCH_TYPE) \
	KERNEL_DIR=$(LINUX_DIR) \
	SOC_PLATFORM=$(GCNANO_BINARIES_SOC_PLATFORM) \
	AQROOT=$(@D)/gcnano-driver-stm32mp \
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
	cd $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/pkgconfig/ ; \
	for file in *.pc ; do \
		sed -e "s|#PREFIX#|/usr|" -e "s|#VERSION#|23.0.3|" $$file > $$file.temp ; \
		$(INSTALL) -D -m 0644 $$file.temp $(1)/usr/lib/pkgconfig/$$file ; \
	done
endef

define GCNANO_BINARIES_INSTALL_TARGET_CMDS
	$(call GCNANO_BINARIES_INSTALL,$(TARGET_DIR))
endef

define GCNANO_BINARIES_INSTALL_STAGING_CMDS
	$(call GCNANO_BINARIES_INSTALL,$(STAGING_DIR))
endef

$(eval $(kernel-module))
$(eval $(generic-package))
