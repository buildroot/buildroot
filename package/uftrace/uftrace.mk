################################################################################
#
# uftrace
#
################################################################################

UFTRACE_VERSION = 0.10
UFTRACE_SITE = $(call github,namhyung,uftrace,v$(UFTRACE_VERSION))
UFTRACE_LICENSE = GPL-2.0
UFTRACE_LICENSE_FILES = COPYING
UFTRACE_CONFIGURE_OPTS = \
	--without-libdw \
	--without-libpython \
	--without-libluajit \
	--without-libncurses \
	--without-capstone

ifeq ($(BR2_i386),y)
UFTRACE_ARCH = i386
else
UFTRACE_ARCH = $(BR2_ARCH)
endif

# Only --without-<foo> options are supported.
ifeq ($(BR2_PACKAGE_ELFUTILS),y)
UFTRACE_DEPENDENCIES += elfutils
else
UFTRACE_CONFIGURE_OPTS += --without-libelf
endif

ifeq ($(BR2_INSTALL_LIBSTDCPP),)
UFTRACE_CONFIGURE_OPTS += --without-libstdc++
endif

UFTRACE_LDFLAGS = $(TARGET_LDFLAGS)

ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
UFTRACE_DEPENDENCIES += argp-standalone
UFTRACE_LDFLAGS += -largp
endif

define UFTRACE_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) \
		LDFLAGS="$(UFTRACE_LDFLAGS)" \
		./configure \
		--arch=$(UFTRACE_ARCH) \
		--prefix=/usr \
		$(UFTRACE_CONFIGURE_OPTS) \
		-o $(@D)/.config)
endef

define UFTRACE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define UFTRACE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
