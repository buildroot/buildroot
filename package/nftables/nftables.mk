################################################################################
#
# nftables
#
################################################################################

NFTABLES_VERSION = 1.1.0
NFTABLES_SOURCE = nftables-$(NFTABLES_VERSION).tar.xz
NFTABLES_SITE = https://www.netfilter.org/projects/nftables/files
NFTABLES_DEPENDENCIES = libmnl libnftnl host-pkgconf $(TARGET_NLS_DEPENDENCIES)
NFTABLES_LICENSE = GPL-2.0
NFTABLES_LICENSE_FILES = COPYING
NFTABLES_INSTALL_STAGING = YES
NFTABLES_SELINUX_MODULES = iptables

# Python bindings are handled by package nftables-python
NFTABLES_CONF_OPTS = \
	--disable-debug \
	--disable-man-doc \
	--disable-pdf-doc \
	--disable-python

ifeq ($(BR2_PACKAGE_GMP),y)
NFTABLES_DEPENDENCIES += gmp
NFTABLES_CONF_OPTS += --without-mini-gmp
else
NFTABLES_CONF_OPTS += --with-mini-gmp
endif

ifeq ($(BR2_PACKAGE_LIBEDIT),y)
NFTABLES_CONF_OPTS += --with-cli=editline
NFTABLES_DEPENDENCIES += libedit
NFTABLES_LIBS += -lncurses
else ifeq ($(BR2_PACKAGE_READLINE),y)
NFTABLES_CONF_OPTS += --with-cli=readline
NFTABLES_DEPENDENCIES += readline
NFTABLES_LIBS += -lncurses
else ifeq ($(BR2_PACKAGE_LINENOISE),y)
NFTABLES_CONF_OPTS += --with-cli=linenoise
NFTABLES_DEPENDENCIES += linenoise
else
NFTABLES_CONF_OPTS += --without-cli
endif

ifeq ($(BR2_PACKAGE_JANSSON),y)
NFTABLES_DEPENDENCIES += jansson
NFTABLES_CONF_OPTS += --with-json
else
NFTABLES_CONF_OPTS += --without-json
endif

NFTABLES_CONF_ENV = LIBS="$(NFTABLES_LIBS)"

define NFTABLES_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETFILTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NF_TABLES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NF_TABLES_INET)
endef

$(eval $(autotools-package))

# Legacy: we used to handle it in this .mk
include package/nftables/nftables-python/nftables-python.mk
