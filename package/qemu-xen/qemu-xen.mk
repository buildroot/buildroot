################################################################################
#
# qemu-xen
#
################################################################################

# We do NOT use GIT_SUBMODULES = YES because qemu-xen has massive ROM
# submodules (edk2, u-boot, etc.) that are not needed for the Xen tools
# cross-build. Instead, we pre-populate only the required meson
# subprojects and remove .wrap files for the rest to prevent any network
# access during the build.

# Determined from Xen repo's hash for this repo @ XEN_VERSION
QEMU_XEN_VERSION = e064f42c80be6f6ff8c12dcb2a663bdf70f965f6
QEMU_XEN_SITE = https://xenbits.xen.org/git-http/qemu-xen.git
QEMU_XEN_SITE_METHOD = git
QEMU_XEN_LICENSE = GPL-2.0
QEMU_XEN_LICENSE_FILES = COPYING
QEMU_XEN_REDISTRIBUTE = NO

# Required meson subprojects for the QEMU build
QEMU_XEN_KEYCODEMAPDB_VERSION = f5772a62ec52591ff6870b7e8ef32482371f22c6
QEMU_XEN_SOFTFLOAT3_VERSION = b64af41c3276f97f0e181920400ee056b9c88037
QEMU_XEN_TESTFLOAT3_VERSION = e7af9751d9f9fd3b47911f51a5cfd08af256a9ab

QEMU_XEN_EXTRA_DOWNLOADS = \
	https://gitlab.com/qemu-project/keycodemapdb/-/archive/$(QEMU_XEN_KEYCODEMAPDB_VERSION)/keycodemapdb-$(QEMU_XEN_KEYCODEMAPDB_VERSION).tar.gz \
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/$(QEMU_XEN_SOFTFLOAT3_VERSION)/berkeley-softfloat-3-$(QEMU_XEN_SOFTFLOAT3_VERSION).tar.gz \
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/$(QEMU_XEN_TESTFLOAT3_VERSION)/berkeley-testfloat-3-$(QEMU_XEN_TESTFLOAT3_VERSION).tar.gz

define QEMU_XEN_INSTALL_SUBPROJECTS
	rm -rf $(@D)/subprojects/keycodemapdb
	mkdir -p $(@D)/subprojects/keycodemapdb
	$(TAR) --strip-components=1 -C $(@D)/subprojects/keycodemapdb \
		-xf $(QEMU_XEN_DL_DIR)/keycodemapdb-$(QEMU_XEN_KEYCODEMAPDB_VERSION).tar.gz
	rm -rf $(@D)/subprojects/berkeley-softfloat-3
	mkdir -p $(@D)/subprojects/berkeley-softfloat-3
	$(TAR) --strip-components=1 -C $(@D)/subprojects/berkeley-softfloat-3 \
		-xf $(QEMU_XEN_DL_DIR)/berkeley-softfloat-3-$(QEMU_XEN_SOFTFLOAT3_VERSION).tar.gz
	cp -f $(@D)/subprojects/packagefiles/berkeley-softfloat-3/* \
		$(@D)/subprojects/berkeley-softfloat-3/
	rm -rf $(@D)/subprojects/berkeley-testfloat-3
	mkdir -p $(@D)/subprojects/berkeley-testfloat-3
	$(TAR) --strip-components=1 -C $(@D)/subprojects/berkeley-testfloat-3 \
		-xf $(QEMU_XEN_DL_DIR)/berkeley-testfloat-3-$(QEMU_XEN_TESTFLOAT3_VERSION).tar.gz
	cp -f $(@D)/subprojects/packagefiles/berkeley-testfloat-3/* \
		$(@D)/subprojects/berkeley-testfloat-3/
	# Remove .wrap files for subprojects we do NOT pre-provide to prevent
	# meson from attempting any network access during the build.
	rm -f $(@D)/subprojects/dtc.wrap
	rm -f $(@D)/subprojects/libblkio.wrap
	rm -f $(@D)/subprojects/libvfio-user.wrap
	rm -f $(@D)/subprojects/slirp.wrap
endef
QEMU_XEN_POST_EXTRACT_HOOKS += QEMU_XEN_INSTALL_SUBPROJECTS

$(eval $(generic-package))
