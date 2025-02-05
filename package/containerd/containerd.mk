################################################################################
#
# containerd
#
################################################################################

CONTAINERD_VERSION = 2.0.2
CONTAINERD_SITE = $(call github,containerd,containerd,v$(CONTAINERD_VERSION))
CONTAINERD_LICENSE = Apache-2.0
CONTAINERD_LICENSE_FILES = LICENSE
CONTAINERD_CPE_ID_VENDOR = linuxfoundation

CONTAINERD_GOMOD = github.com/containerd/containerd/v2

CONTAINERD_LDFLAGS = \
	-X $(CONTAINERD_GOMOD)/version.Version=$(CONTAINERD_VERSION)

CONTAINERD_BUILD_TARGETS = \
	cmd/containerd \
	cmd/containerd-shim-runc-v2 \
	cmd/ctr

CONTAINERD_INSTALL_BINS = $(notdir $(CONTAINERD_BUILD_TARGETS))
CONTAINERD_TAGS = no_aufs

ifeq ($(BR2_PACKAGE_LIBAPPARMOR),y)
CONTAINERD_DEPENDENCIES += libapparmor
CONTAINERD_TAGS += apparmor
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
CONTAINERD_DEPENDENCIES += libseccomp host-pkgconf
CONTAINERD_TAGS += seccomp
endif

ifneq ($(BR2_PACKAGE_CONTAINERD_DRIVER_BTRFS),y)
CONTAINERD_TAGS += no_btrfs
endif

ifneq ($(BR2_PACKAGE_CONTAINERD_DRIVER_DEVMAPPER),y)
CONTAINERD_TAGS += no_devmapper
endif

ifneq ($(BR2_PACKAGE_CONTAINERD_DRIVER_ZFS),y)
CONTAINERD_TAGS += no_zfs
endif

ifneq ($(BR2_PACKAGE_CONTAINERD_CRI),y)
CONTAINERD_TAGS += no_cri
endif

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
# Go exe build with PIE doesn't work with musl.
# See: https://github.com/golang/go/issues/17847
CONTAINERD_EXTLDFLAGS += -Wl,--no-pie
endif

define CONTAINERD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/containerd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/containerd.service
	$(SED) 's,/usr/local/bin,/usr/bin,g' $(TARGET_DIR)/usr/lib/systemd/system/containerd.service
endef

$(eval $(golang-package))
