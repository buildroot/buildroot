################################################################################
#
# lttng-modules
#
################################################################################

LTTNG_MODULES_VERSION = 2.13.7
LTTNG_MODULES_SITE = http://lttng.org/files/lttng-modules
LTTNG_MODULES_SOURCE = lttng-modules-$(LTTNG_MODULES_VERSION).tar.bz2
LTTNG_MODULES_LICENSE = LGPL-2.1/GPL-2.0 (kernel modules), MIT (lib/bitfield.h, lib/prio_heap/*)
LTTNG_MODULES_LICENSE_FILES = \
	LICENSES/LGPL-2.1 LICENSES/GPL-2.0 LICENSES/MIT LICENSE
LTTNG_MODULES_MODULE_MAKE_OPTS = CONFIG_LTTNG=m CONFIG_LTTNG_CLOCK_PLUGIN_TEST=m

define LTTNG_MODULES_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_KPROBES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FTRACE)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
