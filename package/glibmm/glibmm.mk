################################################################################
#
# glibmm
#
################################################################################

GLIBMM_VERSION_MAJOR = 2.76
GLIBMM_VERSION = $(GLIBMM_VERSION_MAJOR).0
GLIBMM_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
GLIBMM_LICENSE_FILES = COPYING COPYING.tools
GLIBMM_SOURCE = glibmm-$(GLIBMM_VERSION).tar.xz
GLIBMM_SITE = https://download.gnome.org/sources/glibmm/$(GLIBMM_VERSION_MAJOR)
GLIBMM_INSTALL_STAGING = YES
GLIBMM_DEPENDENCIES = libglib2 libsigc host-pkgconf
GLIBMM_CONF_OPTS = -Dbuild-examples=false

GLIBMM_CXXFLAGS = $(TARGET_CXXFLAGS)
GLIBMM_LDFLAGS = $(TARGET_LDFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
GLIBMM_CXXFLAGS += -O0
endif

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GLIBMM_LDFLAGS += -latomic
endif

$(eval $(meson-package))
