################################################################################
#
# gstreamer1
#
################################################################################

GSTREAMER1_VERSION = 1.8.1
GSTREAMER1_SOURCE = gstreamer-$(GSTREAMER1_VERSION).tar.xz
GSTREAMER1_SITE = http://gstreamer.freedesktop.org/src/gstreamer
GSTREAMER1_INSTALL_STAGING = YES
GSTREAMER1_LICENSE_FILES = COPYING
GSTREAMER1_LICENSE = LGPLv2+, LGPLv2.1+

ifeq ($(BR2_PACKAGE_GSTREAMER1_GIT),y)
GSTREAMER1_SITE = http://cgit.freedesktop.org/gstreamer/gstreamer/snapshot
BR_NO_CHECK_HASH_FOR += $(GSTREAMER1_SOURCE)
GSTREAMER1_AUTORECONF = YES
GSTREAMER1_AUTORECONF_OPTS = -I $(@D)/common/m4
GSTREAMER1_GETTEXTIZE = YES
GSTREAMER1_POST_EXTRACT_HOOKS += GSTREAMER1_COMMON_EXTRACT
GSTREAMER1_PRE_CONFIGURE_HOOKS += GSTREAMER1_FIX_AUTOPOINT
GSTREAMER1_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES
endif

# Checking if unaligned memory access works correctly cannot be done when cross
# compiling. For the following architectures there is no information available
# in the configure script.
ifeq ($(BR2_arc)$(BR2_xtensa)$(BR2_microblaze)$(BR2_nios2),y)
GSTREAMER1_CONF_ENV = as_cv_unaligned_access=no
endif
ifeq ($(BR2_aarch64),y)
GSTREAMER1_CONF_ENV = as_cv_unaligned_access=yes
endif

GSTREAMER1_CONF_OPTS = \
	--disable-examples \
	--disable-tests \
	--disable-failing-tests \
	--disable-valgrind \
	--disable-benchmarks \
	--disable-check \
	$(if $(BR2_PACKAGE_GSTREAMER1_TRACE),,--disable-trace) \
	$(if $(BR2_PACKAGE_GSTREAMER1_PARSE),,--disable-parse) \
	$(if $(BR2_PACKAGE_GSTREAMER1_GST_DEBUG),,--disable-gst-debug) \
	$(if $(BR2_PACKAGE_GSTREAMER1_PLUGIN_REGISTRY),,--disable-registry) \
	$(if $(BR2_PACKAGE_GSTREAMER1_INSTALL_TOOLS),,--disable-tools)

GSTREAMER1_DEPENDENCIES = libglib2 host-pkgconf host-bison host-flex

ifeq ($(BR2_PACKAGE_GSTREAMER1_GIT),y)
GSTREAMER1_DEPENDENCIES += gst1-common
endif

# gstreamer-1.6 changed the location of its gstconfig.h file,
# and unfortunately, not all (by far!) consumers have been
# updated to look in the correct location.
# Add a symlink to the legacy location
define GSTREAMER1_LEGACY_CGSTCONFIG_H
	cd $(STAGING_DIR)/usr/include/gstreamer-1.0/gst && \
		ln -sf ../../../lib/gstreamer-1.0/include/gst/gstconfig.h .
endef
GSTREAMER1_POST_INSTALL_STAGING_HOOKS += GSTREAMER1_LEGACY_CGSTCONFIG_H

$(eval $(autotools-package))
