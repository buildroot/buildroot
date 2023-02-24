################################################################################
#
# glibmm2_66
#
################################################################################

GLIBMM2_66_VERSION_MAJOR = 2.66
GLIBMM2_66_VERSION = $(GLIBMM2_66_VERSION_MAJOR).5
GLIBMM2_66_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
GLIBMM2_66_LICENSE_FILES = COPYING COPYING.tools
GLIBMM2_66_SOURCE = glibmm-$(GLIBMM2_66_VERSION).tar.xz
GLIBMM2_66_SITE = https://download.gnome.org/sources/glibmm/$(GLIBMM2_66_VERSION_MAJOR)
GLIBMM2_66_INSTALL_STAGING = YES
GLIBMM2_66_DEPENDENCIES = libglib2 libsigc2 host-pkgconf
GLIBMM2_66_CONF_OPTS = -Dbuild-examples=false

GLIBMM2_66_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
GLIBMM2_66_CXXFLAGS += -O0
endif

$(eval $(meson-package))
