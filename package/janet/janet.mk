################################################################################
#
# janet
#
################################################################################

JANET_VERSION = 1.39.1
JANET_SITE = $(call github,janet-lang,janet,v$(JANET_VERSION))
JANET_LICENSE = MIT
JANET_LICENSE_FILES = LICENSE

JANET_INSTALL_STAGING = YES

# don't use posix_spawn_file_actions_addchdir[_np] (in src/core/os.c since 1.39.0)
JANET_CFLAGS = "-DJANET_SPAWN_NO_CHDIR $(TARGET_CFLAGS)"

ifeq ($(BR2_STATIC_LIBS),y)
JANET_CONF_OPTS += -Ddynamic_modules=false
endif

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
JANET_LDFLAGS += $(TARGET_LDFLAGS) -latomic
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),)
JANET_CONF_OPTS += -Dsingle_threaded=true
endif

$(eval $(meson-package))
