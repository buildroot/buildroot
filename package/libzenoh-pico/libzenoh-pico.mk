################################################################################
#
# libzenoh-pico
#
################################################################################

# This 0.11.0 version is really newer than 0.11.0.3, so please don't
# update 0.11.0.3 even if release-monitoring.org claims it's a newer
# version.
LIBZENOH_PICO_VERSION = 0.11.0
LIBZENOH_PICO_SITE = $(call github,eclipse-zenoh,zenoh-pico,$(LIBZENOH_PICO_VERSION))
LIBZENOH_PICO_LICENSE = Apache-2.0 or EPL-2.0
LIBZENOH_PICO_LICENSE_FILES = LICENSE
LIBZENOH_PICO_SUPPORTS_IN_SOURCE_BUILD = NO
LIBZENOH_PICO_INSTALL_STAGING = YES

$(eval $(cmake-package))
