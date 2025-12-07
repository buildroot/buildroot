################################################################################
#
# neon-2-sse
#
################################################################################

NEON_2_SSE_VERSION = 662a85912e8f86ec808f9b15ce77f8715ba53316
NEON_2_SSE_SITE = $(call github,intel,ARM_NEON_2_x86_SSE,$(NEON_2_SSE_VERSION))
NEON_2_SSE_LICENSE = BSD-2-Clause
NEON_2_SSE_LICENSE_FILES = LICENSE
NEON_2_SSE_INSTALL_STAGING = YES
# Only installs a header
NEON_2_SSE_INSTALL_TARGET = NO

$(eval $(cmake-package))
