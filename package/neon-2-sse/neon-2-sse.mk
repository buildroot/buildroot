################################################################################
#
# neon-2-sse
#
################################################################################

NEON_2_SSE_VERSION = 097a5ecacd527d5b5c3006e360fb9cb1c1c48a1f
NEON_2_SSE_SITE = $(call github,intel,ARM_NEON_2_x86_SSE,$(NEON_2_SSE_VERSION))
NEON_2_SSE_LICENSE = BSD-2-Clause
NEON_2_SSE_LICENSE_FILES = LICENSE
NEON_2_SSE_INSTALL_STAGING = YES
# Only installs a header
NEON_2_SSE_INSTALL_TARGET = NO

$(eval $(cmake-package))
