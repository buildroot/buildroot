################################################################################
#
# podman
#
################################################################################

PODMAN_VERSION = v5.4.1
PODMAN_SITE = https://github.com/containers/podman
PODMAN_SITE_METHOD = git

PODMAN_LICENSE = Apache-2.0
PODMAN_LICENSE_FILES = LICENSE

PODMAN_DEPENDENCIES = host-pkgconf libgpgme

PODMAN_GOMOD = github.com/containers/podman/v5
PODMAN_BUILD_TARGETS = cmd/podman
PODMAN_TAGS = selinux

# https://podman.io/docs/installation#get-source-code mandates that flag be
# set, as device-mapper is not officially supported.
PODMAN_TAGS += exclude_graphdriver_devicemapper

# This is supposedly optional, but a basic (busybox:latest) image does not
# even start without seccomp support, unless by passing extra options at
# runtime (--security-opt=seccomp=unconfined), which can't be made the default.
PODMAN_DEPENDENCIES += libseccomp
PODMAN_TAGS += seccomp

# This is required for rootless containers, i.e containers started by non-root
PODMAN_DEPENDENCIES += shadow
PODMAN_TAGS += libsubid

ifeq ($(BR2_PACKAGE_BTRFS_PROGS),y)
PODMAN_DEPENDENCIES += btrfs-progs
define PODMAN_LINUX_CONFIG_FIXUPS_BTRFS
	$(call KCONFIG_ENABLE_OPT,CONFIG_BTRFS_FS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_BTRFS_FS_POSIX_ACL)
endef
else
PODMAN_TAGS += exclude_graphdriver_btrfs
endif

ifeq ($(BR2_PACKAGE_LIBAPPARMOR),y)
PODMAN_DEPENDENCIES += libapparmor
PODMAN_TAGS += apparmor
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
PODMAN_DEPENDENCIES += systemd
PODMAN_TAGS += systemd
endif

PODMAN_INIT_NAME = $(call qstrip,$(BR2_PACKAGE_PODMAN_INIT_NAME))
ifneq ($(PODMAN_INIT_NAME),)
PODMAN_INIT_PATH = /usr/libexec/podman/$(PODMAN_INIT_NAME)
define PODMAN_HELPER_INIT
	$(Q)ln -sf ../../bin/$(PODMAN_INIT_NAME) $(TARGET_DIR)$(PODMAN_INIT_PATH)
	$(Q)mkdir -p $(TARGET_DIR)/etc/containers/containers.conf.d
	$(Q)printf '[containers]\ninit_path = "%s"\n' "$(PODMAN_INIT_PATH)" \
		>$(TARGET_DIR)/etc/containers/containers.conf.d/50-buildroot-init.conf
endef
endif

ifeq ($(BR2_PACKAGE_PODMAN_NET_PASST),y)
define PODMAN_HELPER_PASST
	$(Q)ln -sf ../../bin/pasta $(TARGET_DIR)/usr/libexec/podman/pasta
endef
else
define PODMAN_HELPER_SLIRP4NETNS
	$(Q)ln -sf ../../bin/slirp4netns $(TARGET_DIR)/usr/libexec/podman/slirp4netns
	$(Q)mkdir -p $(TARGET_DIR)/etc/containers/containers.conf.d
	$(Q)printf '[network]\ndefault_rootless_network_cmd = "slirp4netns"\n' \
		>$(TARGET_DIR)/etc/containers/containers.conf.d/50-buildroot-net-backend.conf
endef
endif

define PODMAN_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_CPUSETS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_BPF_SYSCALL)
	$(call KCONFIG_ENABLE_OPT,CONFIG_POSIX_MQUEUE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MEMCG)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUPS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_SCHED)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_FREEZER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_DEVICE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_CPUACCT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_PIDS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_BPF)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NAMESPACES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_UTS_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_IPC_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PID_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USER_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECCOMP)
	$(call KCONFIG_ENABLE_OPT,CONFIG_OVERLAY_FS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_KEYS)
	$(PODMAN_LINUX_CONFIG_FIXUPS_BTRFS)
endef

define PODMAN_CONFIG
	$(Q)$(INSTALL) -D -m 0644 \
		$(PODMAN_PKGDIR)/policy.json \
		$(TARGET_DIR)/etc/containers/policy.json
	$(Q)$(INSTALL) -D -m 0644 \
		$(PODMAN_PKGDIR)/registries.conf \
		$(TARGET_DIR)/etc/containers/registries.conf
endef
PODMAN_POST_INSTALL_TARGET_HOOKS += PODMAN_CONFIG

define PODMAN_HELPERS
	$(Q)mkdir -p $(TARGET_DIR)/usr/libexec/podman
	$(Q)ln -sf ../../bin/aardvark-dns $(TARGET_DIR)/usr/libexec/podman/aardvark-dns
	$(Q)ln -sf ../../bin/netavark $(TARGET_DIR)/usr/libexec/podman/netavark
	$(PODMAN_HELPER_INIT)
	$(PODMAN_HELPER_PASST)
	$(PODMAN_HELPER_SLIRP4NETNS)
endef
PODMAN_POST_INSTALL_TARGET_HOOKS += PODMAN_HELPERS

$(eval $(golang-package))
