################################################################################
#
# hackrf
#
################################################################################

HACKRF_VERSION = v2024.02.1-118-g390837715b3741902b1b13c899bfd04a0bb6b0da
HACKRF_SITE = $(call github,greatscottgadgets,hackrf,$(HACKRF_VERSION))
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
