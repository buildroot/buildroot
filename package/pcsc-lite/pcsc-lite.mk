################################################################################
#
# pcsc-lite
#
################################################################################

PCSC_LITE_VERSION = 2.5.2
PCSC_LITE_SOURCE = pcsc-lite-$(PCSC_LITE_VERSION).tar.xz
PCSC_LITE_SITE = https://pcsclite.apdu.fr/files
PCSC_LITE_INSTALL_STAGING = YES
PCSC_LITE_DEPENDENCIES = host-pkgconf host-flex
PCSC_LITE_LICENSE = BSD-2-Clause (auth), BSD-3-Clause, GPL-3.0+ (spy, tests), ISC (simclist)
PCSC_LITE_LICENSE_FILES = COPYING GPL-3.0.txt
PCSC_LITE_SELINUX_MODULES = pcscd
PCSC_LITE_CONF_OPTS = -Dsystemdunit=system

# - libudev and libusb are optional
# - libudev and libusb can't be used together
# - libudev has a priority over libusb

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
PCSC_LITE_CONF_OPTS += -Dlibudev=true -Dlibusb=false
PCSC_LITE_DEPENDENCIES += udev
else
ifeq ($(BR2_PACKAGE_LIBUSB),y)
PCSC_LITE_CONF_OPTS += -Dlibusb=true -Dlibudev=false
PCSC_LITE_DEPENDENCIES += libusb
else
PCSC_LITE_CONF_OPTS += -Dlibusb=false -Dlibudev=false
endif
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
PCSC_LITE_CONF_OPTS += -Dlibsystemd=true
PCSC_LITE_DEPENDENCIES += systemd
else
PCSC_LITE_CONF_OPTS += -Dlibsystemd=false
endif

ifeq ($(BR2_PACKAGE_PCSC_LITE_DEBUGATR),y)
PCSC_LITE_CFLAGS = $(TARGET_CFLAGS) -DATR_DEBUG
endif

ifeq ($(BR2_PACKAGE_PCSC_LITE_EMBEDDED),y)
PCSC_LITE_CONF_OPTS += -Dembedded=true
else
PCSC_LITE_CONF_OPTS += -Dembedded=false
endif

ifeq ($(BR2_PACKAGE_POLKIT),y)
PCSC_LITE_CONF_OPTS += -Dpolkit=true
PCSC_LITE_DEPENDENCIES += polkit
else
PCSC_LITE_CONF_OPTS += -Dpolkit=false
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
PCSC_LITE_LDFLAGS = $(TARGET_LDFLAGS) -latomic
endif

define PCSC_LITE_USERS
	pcscd -1 pcscd -1 * - - - PC/SC Smart Card Daemon
endef

$(eval $(meson-package))
