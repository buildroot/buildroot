################################################################################
#
# zstd
#
################################################################################

ZSTD_VERSION = 1.5.2
ZSTD_SITE = https://github.com/facebook/zstd/releases/download/v$(ZSTD_VERSION)
ZSTD_INSTALL_STAGING = YES
ZSTD_LICENSE = BSD-3-Clause or GPL-2.0
ZSTD_LICENSE_FILES = LICENSE COPYING
ZSTD_CPE_ID_VENDOR = facebook
ZSTD_CPE_ID_PRODUCT = zstandard

ZSTD_OPTS += PREFIX=/usr
ZSTD_OPTS += ZSTD_LEGACY_SUPPORT=0
ifeq ($(BR2_PACKAGE_ZLIB),y)
ZSTD_DEPENDENCIES += zlib
ZSTD_OPTS += HAVE_ZLIB=1
else
ZSTD_OPTS += HAVE_ZLIB=0
endif

ifeq ($(BR2_PACKAGE_XZ),y)
ZSTD_DEPENDENCIES += xz
ZSTD_OPTS += HAVE_LZMA=1
else
ZSTD_OPTS += HAVE_LZMA=0
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
ZSTD_DEPENDENCIES += lz4
ZSTD_OPTS += HAVE_LZ4=1
else
ZSTD_OPTS += HAVE_LZ4=0
endif

# zstd will append -O3 after $(CFLAGS), use MOREFLAGS to override again
ZSTD_OPTS += MOREFLAGS="$(TARGET_OPTIMIZATION)"

ifeq ($(BR2_STATIC_LIBS),y)
ZSTD_BUILD_LIBS = libzstd.a
ZSTD_INSTALL_LIBS = install-static
else ifeq ($(BR2_SHARED_LIBS),y)
ZSTD_BUILD_LIBS = lib
ZSTD_INSTALL_LIBS = install-shared
else
ZSTD_BUILD_LIBS = lib
ZSTD_INSTALL_LIBS = install-static install-shared
endif

# prefer zstd-dll unless no library is available
ifeq ($(BR2_STATIC_LIBS),y)
ZSTD_BUILD_PROG_TARGET = zstd-release
else
ZSTD_BUILD_PROG_TARGET = zstd-dll
endif

# The HAVE_THREAD flag is read by the 'programs' makefile but not by  the 'lib'
# one. Building a multi-threaded binary with a static library (which defaults
# to single-threaded) gives a runtime error when compressing files.
# The 'lib' makefile provides specific '%-mt' and '%-nomt' targets for this
# purpose.
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
ZSTD_OPTS += HAVE_THREAD=1
ZSTD_BUILD_LIBS := $(addsuffix -mt,$(ZSTD_BUILD_LIBS))
else
ZSTD_OPTS += HAVE_THREAD=0
ZSTD_BUILD_LIBS := $(addsuffix -nomt,$(ZSTD_BUILD_LIBS))
endif
# check-package disable OverriddenVariable - override intended
ZSTD_BUILD_LIBS := $(addsuffix -release,$(ZSTD_BUILD_LIBS))

define ZSTD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(ZSTD_OPTS) \
		-C $(@D)/lib $(ZSTD_BUILD_LIBS) libzstd.pc
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(ZSTD_OPTS) \
		-C $(@D)/programs $(ZSTD_BUILD_PROG_TARGET)
endef

define ZSTD_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(ZSTD_OPTS) \
		DESTDIR=$(STAGING_DIR) PREFIX=/usr -C $(@D)/lib \
		install-pc install-includes $(ZSTD_INSTALL_LIBS)
endef

define ZSTD_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(ZSTD_OPTS) \
		DESTDIR=$(TARGET_DIR) -C $(@D)/programs install
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(ZSTD_OPTS) \
		DESTDIR=$(TARGET_DIR) -C $(@D)/lib $(ZSTD_INSTALL_LIBS)
endef

HOST_ZSTD_OPTS += PREFIX=$(HOST_DIR)

define HOST_ZSTD_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) $(HOST_ZSTD_OPTS) \
		-C $(@D) zstd-release lib-release
endef

define HOST_ZSTD_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) $(HOST_ZSTD_OPTS) \
		-C $(@D) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
