################################################################################
#
# hackrf
#
################################################################################

HACKRF_VERSION = 2023.01.1
HACKRF_SITE = https://github.com/greatscottgadgets/hackrf/releases/download/v$(HACKRF_VERSION)
HACKRF_SOURCE = hackrf-$(HACKRF_VERSION).tar.xz
HACKRF_LICENSE = GPL-2.0+, BSD-3-Clause
HACKRF_LICENSE_FILES = COPYING
HACKRF_DEPENDENCIES = fftw-single libusb
HACKRF_SUBDIR = host
HACKRF_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
HACKRF_CONF_OPTS += \
	-DINSTALL_UDEV_RULES=ON \
	-DUDEV_RULES_GROUP=plugdev
else
HACKRF_CONF_OPTS += -DINSTALL_UDEV_RULES=OFF
endif

$(eval $(cmake-package))
