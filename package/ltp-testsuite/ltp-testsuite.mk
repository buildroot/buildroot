################################################################################
#
# ltp-testsuite
#
################################################################################

LTP_TESTSUITE_VERSION = 20250130
LTP_TESTSUITE_SOURCE = ltp-full-$(LTP_TESTSUITE_VERSION).tar.xz
LTP_TESTSUITE_SITE = https://github.com/linux-test-project/ltp/releases/download/$(LTP_TESTSUITE_VERSION)

LTP_TESTSUITE_LICENSE = GPL-2.0, GPL-2.0+
LTP_TESTSUITE_LICENSE_FILES = COPYING

LTP_TESTSUITE_CONF_OPTS += --disable-metadata

ifeq ($(BR2_PACKAGE_LTP_TESTSUITE_OPEN_POSIX),y)
LTP_TESTSUITE_CONF_OPTS += --with-open-posix-testsuite
endif

ifeq ($(BR2_PACKAGE_LTP_TESTSUITE_REALTIME),y)
LTP_TESTSUITE_CONF_OPTS += --with-realtime-testsuite
endif

ifeq ($(BR2_LINUX_KERNEL),y)
LTP_TESTSUITE_DEPENDENCIES += linux
LTP_TESTSUITE_MAKE_ENV += $(LINUX_MAKE_FLAGS)
LTP_TESTSUITE_CONF_OPTS += --with-linux-dir=$(LINUX_DIR)
else
LTP_TESTSUITE_CONF_OPTS += --without-modules
endif

# We change the prefix to a custom one, otherwise we get scripts and
# directories directly in /usr, such as /usr/runalltests.sh
LTP_TESTSUITE_CONF_OPTS += --prefix=/usr/lib/ltp-testsuite

# Needs libcap with file attrs which needs attr, so both required
ifeq ($(BR2_PACKAGE_LIBCAP)$(BR2_PACKAGE_ATTR),yy)
LTP_TESTSUITE_DEPENDENCIES += libcap
else
LTP_TESTSUITE_CONF_ENV += ac_cv_lib_cap_cap_compare=no
endif

# No explicit enable/disable options
ifeq ($(BR2_PACKAGE_NUMACTL),y)
LTP_TESTSUITE_DEPENDENCIES += numactl
else
LTP_TESTSUITE_CONF_ENV += have_numa_headers=no
endif

LTP_TESTSUITE_CFLAGS = $(TARGET_CFLAGS)
LTP_TESTSUITE_LIBS =

ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
LTP_TESTSUITE_DEPENDENCIES += libtirpc host-pkgconf
LTP_TESTSUITE_CFLAGS += "`$(PKG_CONFIG_HOST_BINARY) --cflags libtirpc`"
LTP_TESTSUITE_LIBS += "`$(PKG_CONFIG_HOST_BINARY) --libs libtirpc`"
endif

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
LTP_TESTSUITE_DEPENDENCIES += musl-fts
LTP_TESTSUITE_LIBS += -lfts
endif

LTP_TESTSUITE_CONF_ENV += \
	CFLAGS="$(LTP_TESTSUITE_CFLAGS)" \
	LIBS="$(LTP_TESTSUITE_LIBS)" \
	SYSROOT="$(STAGING_DIR)"

LTP_TESTSUITE_MAKE_ENV += \
	HOST_CFLAGS="$(HOST_CFLAGS)" \
	HOST_LDFLAGS="$(HOST_LDFLAGS)"

# uclibc: bessel support normally not enabled
LTP_TESTSUITE_UNSUPPORTED_TEST_CASES_$(BR2_TOOLCHAIN_USES_UCLIBC) += \
	testcases/misc/math/float/bessel/ \
	testcases/misc/math/float/float_bessel.c

LTP_TESTSUITE_UNSUPPORTED_TEST_CASES_$(BR2_TOOLCHAIN_USES_MUSL) += \
	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
	testcases/kernel/syscalls/timer_create/timer_create01.c \
	testcases/kernel/syscalls/timer_create/timer_create03.c

# ldd command build system tries to build a shared library unconditionally.
LTP_TESTSUITE_UNSUPPORTED_TEST_CASES_$(BR2_STATIC_LIBS) += \
	testcases/commands/ldd

define LTP_TESTSUITE_REMOVE_UNSUPPORTED_TESTCASES
	$(foreach f,$(LTP_TESTSUITE_UNSUPPORTED_TEST_CASES_y),
		rm -rf $(@D)/$(f)
	)
endef

LTP_TESTSUITE_POST_PATCH_HOOKS += LTP_TESTSUITE_REMOVE_UNSUPPORTED_TESTCASES

$(eval $(autotools-package))
