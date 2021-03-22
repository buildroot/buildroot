################################################################################
#
# libyxope
#
################################################################################
LIBYXOPE_VERSION = 1.0
LIBYXOPE_SITE=$(TOPDIR)/package/libyxope/src
LIBYXOPE_SITE_METHOD=local

LIBYXOPE_INSTALL_STAGING = YES
LIBYXOPE_INSTALL_TARGET = YES

LIBYXOPE_LICENSE_FILE = COPYING 
LIBYXOPE_REDISTRIBUTE = YES

LIBYXOPE_DEPENDENCIES = libdrm mesa3d

# The target flags
LIBYXOPE_CPPFLAGS = $(TARGET_CPPFLAGS)
LIBYXOPE_CFLAGS = $(TARGET_CFLAGS)
LIBYXOPE_CXXFLAGS = $(TARGET_CXXFLAGS) -Wall
LIBYXOPE_LDFLAGS = $(TARGET_LDFLAGS)

override LIBYXOPE_CFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --cflags libdrm)
override LIBYXOPE_CXXFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --cflags libdrm)
override LIBYXOPE_LDFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --libs libdrm)
override LIBYXOPE_CFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --cflags gbm)
override LIBYXOPE_CXXFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --cflags gbm)
override LIBYXOPE_LDFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --libs gbm)

ifeq ($(BR2_ENABLE_DEBUG)x,yx)
    LIBYXOPE_CPPFLAGS += -DDEBUG
else
    LIBYXOPE_CPPFLAGS += -DNDEBUG
endif

#LIBYXOPE_CPPFLAGS += -D_FIXEDSIZEDQUEUE
#LIBYXOPE_CPPFLAGS += -D_ENABLE_BENCHMARK
#LIBYXOPE_CPPFLAGS += -D_FORCE_CLEANUP

define LIBYXOPE_CONFIGURE_CMDS
@echo "Nothing to be done"
endef

define LIBYXOPE_BUILD_CMDS
pushd $(@D) && \
$(MAKE) -f $(@D)/Makefile CC="$(TARGET_CROSS)cc" CXX="$(TARGET_CROSS)c++" CPPFLAGS="$(LIBYXOPE_CPPFLAGS)" CFLAGS="$(LIBYXOPE_CFLAGS)" CXXFLAGS="$(LIBYXOPE_CXXFLAGS)" LDFLAGS="$(LIBYXOPE_LDFLAGS)" && \
popd; 
endef

define LIBYXOPE_INSTALLER =
[ -n $(notdir $(wildcard $(realpath $(2)/usr/lib/lib$(1).so))) ] && \
[ -f $(wildcard $(realpath $(2)/usr/lib/lib$(1).so)) ] && \
$(INSTALL) -D -m 755 $(realpath $(2)/usr/lib/lib$(1).so) $(subst $(1),Real$(1),$(realpath $(2)/usr/lib/lib$(1).so)) && \
$(INSTALL) -D -m 755 $(@D)/.bin/lib$(1).so $(realpath $(2)/usr/lib/lib$(1).so) && \
pushd $(2)/usr/lib/ && \
[ -L libReal$(1).so ] && rm libReal$(1).so || true && \
ln -s $(subst $(1),Real$(1),$(notdir $(wildcard $(realpath $(2)/usr/lib/lib$(1).so)))) libReal$(1).so && \
popd
endef

define LIBYXOPE_INSTALL_STAGING_CMDS
$(call LIBYXOPE_INSTALLER,gbm,$(STAGING_DIR))
$(call LIBYXOPE_INSTALLER,EGL,$(STAGING_DIR))
endef

define LIBYXOPE_INSTALL_TARGET_CMDS
$(call LIBYXOPE_INSTALLER,gbm,$(TARGET_DIR))
$(call LIBYXOPE_INSTALLER,EGL,$(TARGET_DIR))
endef

$(eval $(generic-package))
