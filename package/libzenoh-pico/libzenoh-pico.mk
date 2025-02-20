################################################################################
#
# libzenoh-pico
#
################################################################################

LIBZENOH_PICO_VERSION = 1.2.1
LIBZENOH_PICO_SITE = $(call github,eclipse-zenoh,zenoh-pico,$(LIBZENOH_PICO_VERSION))
LIBZENOH_PICO_LICENSE = Apache-2.0 or EPL-2.0
LIBZENOH_PICO_LICENSE_FILES = LICENSE
LIBZENOH_PICO_SUPPORTS_IN_SOURCE_BUILD = NO
LIBZENOH_PICO_INSTALL_STAGING = YES

$(eval $(cmake-package))
