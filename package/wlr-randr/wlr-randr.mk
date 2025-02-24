################################################################################
#
# wlr-randr
#
################################################################################

WLR_RANDR_VERSION = 0.5.0
WLR_RANDR_SITE = https://gitlab.freedesktop.org/emersion/wlr-randr/-/releases/v$(WLR_RANDR_VERSION)/downloads
WLR_RANDR_LICENSE = MIT
WLR_RANDR_LICENSE_FILES = LICENSE
# host-wayland is for wayland-scanner
WLR_RANDR_DEPENDENCIES = host-pkgconf host-wayland wayland

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
# uClibc < 1.0.38 does not expose strdup() when _POSIX_C_SOURCE >= 200809L
# See: https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/commit/?id=0daab1508379e23a09ab7fdb469018228d951894
# We define _XOPEN_SOURCE=500 as a workaround.
WLR_RANDR_CONF_OPTS += -Dc_args=-D_XOPEN_SOURCE=500
endif

$(eval $(meson-package))
