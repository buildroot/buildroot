################################################################################
#
# gcnano-binaries
#
################################################################################

GCNANO_BINARIES_LIB_VERSION = 6.4.7
GCNANO_BINARIES_DRIVER_VERSION = $(GCNANO_BINARIES_LIB_VERSION)
GCNANO_BINARIES_USERLAND_VERSION = $(GCNANO_BINARIES_LIB_VERSION)-20220524
GCNANO_BINARIES_VERSION = a20611434ef048d3d0c04f55b6cd7d75a2156d43
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
	SOC_PLATFORM=st-st \
	AQROOT=$(@D) \
	DEBUG=0

GCNANO_BINARIES_USERLAND_SUBDIR = gcnano-userland-multi-$(GCNANO_BINARIES_USERLAND_VERSION)

# This creates:
#   libGLESv2.so.2    -> libGLESv2.so
#   libGLESv1_CM.so.1 -> libGLESv1_CM.so
# symlinks, as most OpenGL implementations have them, and they are
# expected by some users such as libepoxy.
define GCNANO_BINARIES_INSTALL
	cd $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/release/drivers/ ; \
	find . -type f -exec $(INSTALL) -D -m 0755 {} $(1)/usr/lib/{} \; ; \
	find . -type l -exec cp -a {} $(1)/usr/lib \;
	ln -sf libGLESv2.so $(1)/usr/lib/libGLESv2.so.2
	ln -sf libGLESv1_CM.so $(1)/usr/lib/libGLESv1_CM.so.1
	mkdir -p $(1)/usr/include
	cp -a $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/release/include/* $(1)/usr/include/
	ln -sf gbm/gbm.h $(1)/usr/include/gbm.h
	cd $(@D)/$(GCNANO_BINARIES_USERLAND_SUBDIR)/pkgconfig/ ; \
	for file in *.pc ; do \
		sed -e "s|#PREFIX#|/usr|" -e "s|#VERSION#|21.1.1|" $$file > $$file.temp ; \
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
