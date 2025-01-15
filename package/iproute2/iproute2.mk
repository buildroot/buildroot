################################################################################
#
# iproute2
#
################################################################################

IPROUTE2_VERSION = 6.12.0
IPROUTE2_SOURCE = iproute2-$(IPROUTE2_VERSION).tar.xz
IPROUTE2_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/net/iproute2
IPROUTE2_DEPENDENCIES = host-bison host-flex host-pkgconf \
	$(if $(BR2_PACKAGE_LIBMNL),libmnl)
IPROUTE2_LICENSE = GPL-2.0+
IPROUTE2_LICENSE_FILES = COPYING
IPROUTE2_CPE_ID_VALID = YES

ifeq ($(BR2_PACKAGE_ELFUTILS),y)
IPROUTE2_DEPENDENCIES += elfutils
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
IPROUTE2_DEPENDENCIES += libcap
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
IPROUTE2_DEPENDENCIES += libselinux
endif

ifeq ($(BR2_PACKAGE_IPTABLES)x$(BR2_STATIC_LIBS),yx)
IPROUTE2_DEPENDENCIES += iptables
else
define IPROUTE2_DISABLE_IPTABLES
	# m_xt.so is built unconditionally
	echo "TC_CONFIG_XT:=n" >>$(@D)/config.mk
endef
endif

ifeq ($(BR2_PACKAGE_BERKELEYDB_COMPAT185),y)
IPROUTE2_DEPENDENCIES += berkeleydb
endif

ifeq ($(BR2_PACKAGE_LIBBPF),y)
IPROUTE2_DEPENDENCIES += libbpf
IPROUTE2_CONFIGURE_OPTS += --libbpf_force on
else
IPROUTE2_CONFIGURE_OPTS += --libbpf_force off
endif

define IPROUTE2_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_CONFIGURE_OPTS) ./configure \
		$(IPROUTE2_CONFIGURE_OPTS)
	$(IPROUTE2_DISABLE_IPTABLES)
endef

# workaround for static_assert on uclibc-ng < 1.0.42
IPROUTE2_CFLAGS = $(TARGET_CFLAGS) -Dstatic_assert=_Static_assert

define IPROUTE2_BUILD_CMDS
	$(TARGET_MAKE_ENV) LDFLAGS="$(TARGET_LDFLAGS)" \
		CFLAGS="$(IPROUTE2_CFLAGS) -DXT_LIB_DIR=\\\"/usr/lib/xtables\\\"" \
		CBUILD_CFLAGS="$(HOST_CFLAGS)" $(MAKE) V=1 LIBDB_LIBS=-lpthread \
		DBM_INCLUDE="$(STAGING_DIR)/usr/include" \
		SHARED_LIBS="$(if $(BR2_STATIC_LIBS),n,y)" -C $(@D)
endef

define IPROUTE2_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
