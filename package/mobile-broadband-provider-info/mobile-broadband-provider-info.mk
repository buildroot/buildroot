################################################################################
#
# mobile-broadband-provider-info
#
################################################################################

MOBILE_BROADBAND_PROVIDER_INFO_VERSION = 20251101
MOBILE_BROADBAND_PROVIDER_INFO_SITE = https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info/-/archive/$(MOBILE_BROADBAND_PROVIDER_INFO_VERSION)
MOBILE_BROADBAND_PROVIDER_INFO_SOURCE = mobile-broadband-provider-info-$(MOBILE_BROADBAND_PROVIDER_INFO_VERSION).tar.bz2
MOBILE_BROADBAND_PROVIDER_INFO_LICENSE = Public domain
MOBILE_BROADBAND_PROVIDER_INFO_LICENSE_FILES = COPYING
MOBILE_BROADBAND_PROVIDER_INFO_INSTALL_STAGING = YES
MOBILE_BROADBAND_PROVIDER_INFO_DEPENDENCIES = host-pkgconf host-libxslt

$(eval $(meson-package))
