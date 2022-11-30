################################################################################
#
# kmemd
#
################################################################################

KMEMD_VERSION = 1.0.0
KMEMD_SITE = https://github.com/wkz/kmemd/releases/download/$(KMEMD_VERSION)
KMEMD_LICENSE = GPL-2.0
KMEMD_LICENSE_FILES = COPYING
KMEMD_DEPENDENCIES = libbpf

define KMEMD_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_BPF_SYSCALL)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FTRACE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_KPROBES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PERF_EVENTS)
endef

$(eval $(autotools-package))
