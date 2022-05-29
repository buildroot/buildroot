################################################################################
#
# janet
#
################################################################################

JANET_VERSION = 1.22.0
JANET_SITE = $(call github,janet-lang,janet,v$(JANET_VERSION))
JANET_LICENSE = MIT
JANET_LICENSE_FILES = LICENSE

JANET_INSTALL_STAGING = YES

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
