################################################################################
#
# libmnl
#
################################################################################

LIBMNL_VERSION = 1.0.5
LIBMNL_SOURCE = libmnl-$(LIBMNL_VERSION).tar.bz2
LIBMNL_SITE = https://netfilter.org/projects/libmnl/files
LIBMNL_INSTALL_STAGING = YES
LIBMNL_LICENSE = LGPL-2.1+
LIBMNL_LICENSE_FILES = COPYING
LIBMNL_CPE_ID_VENDOR = netfilter
# 0001-examples-add-rtnl-link-can.patch patches Makefile.am
# 0002-include-cache-copy-of-can.h-and-can-netlink.h.patch patches configure.ac
LIBMNL_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_LIBMNL_EXAMPLES),y)
define LIBMNL_EXAMPLES_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) check -C $(@D)
endef
LIBMNL_POST_BUILD_HOOKS += LIBMNL_EXAMPLES_BUILD_CMDS

LIBMNL_EXAMPLES_INSTALL_TARGETS = \
	$(addprefix examples/genl/, genl-family-get genl-group-events) \
	$(addprefix examples/kobject/, kobject-event) \
	$(addprefix examples/netfilter/, nfct-create-batch \
		nfct-daemon nfct-dump nfct-event nf-log \
		nf-queue) \
	$(addprefix examples/rtnl/, rtnl-addr-add rtnl-addr-dump \
		rtnl-link-can rtnl-link-dump rtnl-link-dump2 rtnl-link-dump3 \
		rtnl-link-event rtnl-link-set rtnl-neigh-dump \
		rtnl-route-add rtnl-route-dump rtnl-route-event)

define LIBMNL_EXAMPLES_INSTALL_TARGET_CMDS
	$(foreach t,$(LIBMNL_EXAMPLES_INSTALL_TARGETS), \
		$(INSTALL) -D -m 0755 $(@D)/$(t) \
			$(TARGET_DIR)/usr/bin/$(notdir $(t))$(sep))
endef
LIBMNL_POST_INSTALL_TARGET_HOOKS += LIBMNL_EXAMPLES_INSTALL_TARGET_CMDS
endif

$(eval $(autotools-package))
