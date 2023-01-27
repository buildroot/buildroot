################################################################################
#
# neon-2-sse
#
################################################################################

NEON_2_SSE_VERSION = a15b489e1222b2087007546b4912e21293ea86ff
NEON_2_SSE_SITE = $(call github,intel,ARM_NEON_2_x86_SSE,$(NEON_2_SSE_VERSION))
NEON_2_SSE_LICENSE = BSD-2-Clause
NEON_2_SSE_LICENSE_FILES = LICENSE
NEON_2_SSE_INSTALL_STAGING = YES
NEON_2_SSE_INSTALL_TARGET = NO

$(eval $(cmake-package))
