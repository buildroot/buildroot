################################################################################
#
# nnn
#
################################################################################

NNN_VERSION = 5.1
NNN_LICENSE = BSD-2-Clause
NNN_LICENSE_FILES = LICENSE
NNN_SITE = $(call github,jarun,nnn,v$(NNN_VERSION))
NNN_DEPENDENCIES = ncurses host-pkgconf

NNN_MAKE_ENV = $(TARGET_CONFIGURE_OPTS)
NNN_MAKE_FLAGS = \
	CFLAGS_OPTIMIZATION= \
	PREFIX=/usr

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
NNN_DEPENDENCIES += musl-fts
# Must be passed in env so it can be appended to by the Makefile
NNN_MAKE_ENV += LDLIBS="-lfts"
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
NNN_DEPENDENCIES += readline
NNN_MAKE_FLAGS += O_NORL=0
else
NNN_MAKE_FLAGS += O_NORL=1
endif

define NNN_BUILD_CMDS
	$(NNN_MAKE_ENV) $(MAKE) -C $(@D) $(NNN_MAKE_FLAGS)
endef

define NNN_INSTALL_TARGET_CMDS
	$(NNN_MAKE_ENV) $(MAKE) -C $(@D) $(NNN_MAKE_FLAGS) \
		DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
