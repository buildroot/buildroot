################################################################################
#
# iptables
#
################################################################################

IPTABLES_VERSION = 1.8.11
IPTABLES_SOURCE = iptables-$(IPTABLES_VERSION).tar.xz
IPTABLES_SITE = https://netfilter.org/projects/iptables/files
IPTABLES_INSTALL_STAGING = YES
IPTABLES_DEPENDENCIES = host-pkgconf
IPTABLES_LICENSE = GPL-2.0
IPTABLES_LICENSE_FILES = COPYING
IPTABLES_CPE_ID_VENDOR = netfilter
IPTABLES_SELINUX_MODULES = iptables

# Building static causes ugly warnings on some plugins
IPTABLES_CONF_OPTS = --libexecdir=/usr/lib --with-kernel=$(STAGING_DIR)/usr \
	$(if $(BR2_STATIC_LIBS),,--disable-static)

# For connlabel match
ifeq ($(BR2_PACKAGE_LIBNETFILTER_CONNTRACK),y)
IPTABLES_DEPENDENCIES += libnetfilter_conntrack
endif

# For nfnl_osf
ifeq ($(BR2_PACKAGE_LIBNFNETLINK),y)
IPTABLES_DEPENDENCIES += libnfnetlink
endif

# For iptables-compat tools
ifeq ($(BR2_PACKAGE_IPTABLES_NFTABLES),y)
IPTABLES_CONF_OPTS += --enable-nftables
IPTABLES_DEPENDENCIES += host-bison host-flex libmnl libnftnl
else
IPTABLES_CONF_OPTS += --disable-nftables
endif

# bpf compiler support and nfsynproxy tool
ifeq ($(BR2_PACKAGE_IPTABLES_BPF_NFSYNPROXY),y)
# libpcap is tricky for static-only builds and needs help
ifeq ($(BR2_STATIC_LIBS),y)
IPTABLES_LIBS_FOR_STATIC_LINK += `$(STAGING_DIR)/usr/bin/pcap-config --static --additional-libs`
IPTABLES_CONF_OPTS += LIBS="$(IPTABLES_LIBS_FOR_STATIC_LINK)"
endif
IPTABLES_CONF_OPTS += --enable-bpf-compiler --enable-nfsynproxy
IPTABLES_DEPENDENCIES += libpcap
else
IPTABLES_CONF_OPTS += --disable-bpf-compiler --disable-nfsynproxy
endif

define IPTABLES_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_IP_NF_IPTABLES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_IP_NF_FILTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETFILTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETFILTER_XTABLES)
endef

define IPTABLES_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/iptables/S35iptables \
		$(TARGET_DIR)/etc/init.d/S35iptables
	touch $(TARGET_DIR)/etc/iptables.conf
endef

$(eval $(autotools-package))
