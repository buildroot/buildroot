################################################################################
#
# vboot-utils
#
################################################################################

VBOOT_UTILS_VERSION = 4b12d392e5b12de29c582df4e717b1228e9f1594
VBOOT_UTILS_SITE = https://chromium.googlesource.com/chromiumos/platform/vboot_reference
VBOOT_UTILS_SITE_METHOD = git
VBOOT_UTILS_LICENSE = BSD-3-Clause
VBOOT_UTILS_LICENSE_FILES = LICENSE

HOST_VBOOT_UTILS_DEPENDENCIES = host-openssl host-util-linux host-pkgconf

# vboot_reference contains code that goes into bootloaders,
# utilities intended for the target system, and a bunch of scripts
# for Chromium OS build system. Most of that does not make sense
# in a buildroot host-package.
#
# We only need futility for signing images, the keys, and cgpt for boot
# media partitioning.
#
# make target for futility is "futil".
#
# The value of ARCH is only relevant for crossystem (a target tool) and
# does not affect futil or cgpt in any way as long as it is one of the
# supported targets.

HOST_VBOOT_UTILS_MAKE_OPTS = USE_FLASHROM=0

define HOST_VBOOT_UTILS_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_VBOOT_UTILS_MAKE_OPTS) -C $(@D) \
		CC="$(HOSTCC)" \
		CPPFLAGS="$(HOST_CFLAGS) -D_LARGEFILE64_SOURCE -D_GNU_SOURCE" \
		LDFLAGS="$(HOST_LDFLAGS)" \
		ARCH=arm \
		futil cgpt
endef

define HOST_VBOOT_UTILS_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_VBOOT_UTILS_MAKE_OPTS) -C $(@D) \
		DESTDIR=$(HOST_DIR) \
		futil_install cgpt_install devkeys_install
endef

$(eval $(host-generic-package))
