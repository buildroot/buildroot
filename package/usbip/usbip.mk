################################################################################
#
# usbip
#
################################################################################

# Since linux 3.17, usbip is part of the linux source tree. Usually, we'd add
# such a tool in the linux-tools package.
#
# However, usbip is autotools-based, so we'd have to duplicate the autotools
# infra in linux-tools; the basic infra is easy to duplicate, but then come
# the conditional libtool patches, and it's not trivial to do. And of course,
# there would be the maintenance cost...
#
# usbip is not very tied to the kernel, in fact. It is pretty stable, API-wise,
# so we can just use a recent kernel version.
USBIP_VERSION = 6.12.6
USBIP_SOURCE = linux-$(USBIP_VERSION).tar.xz
USBIP_SITE = $(BR2_KERNEL_MIRROR)/linux/kernel/v6.x
USBIP_DL_SUBDIR = linux

# usbip's licensing diverges from that of the rest of the kernel
USBIP_LICENSE = GPL-2.0-or-later
USBIP_LICENSE_FILES = tools/usb/usbip/COPYING

USBIP_DEPENDENCIES = udev

USBIP_SUBDIR = tools/usb/usbip
USBIP_INSTALL_STAGING = YES

USBIP_AUTORECONF = YES
USBIP_CONFIGURE_OPTS = --without-tcp-wrappers

define USBIP_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USBIP_CORE)
endef

$(eval $(autotools-package))
