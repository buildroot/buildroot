################################################################################
#
# gstreamermm
#
################################################################################

GSTREAMERMM_VERSION_MAJOR = 1.8
GSTREAMERMM_VERSION = $(GSTREAMERMM_VERSION_MAJOR).0
GSTREAMERMM_SOURCE = gstreamermm-$(GSTREAMERMM_VERSION).tar.xz
GSTREAMERMM_SITE = https://download.gnome.org/sources/gstreamermm/$(GSTREAMERMM_VERSION_MAJOR)
GSTREAMERMM_LICENSE = LGPLv2.1+ (library), GPLv2+ (tools, examples)
GSTREAMERMM_LICENSE_FILES = COPYING COPYING.tools COPYING.examples
GSTREAMERMM_INSTALL_STAGING = YES
GSTREAMERMM_DEPENDENCIES = glibmm libsigc host-pkgconf

$(eval $(autotools-package))
