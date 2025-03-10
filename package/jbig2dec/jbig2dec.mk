################################################################################
#
# jbig2dec
#
################################################################################

JBIG2DEC_VERSION = 0.20
JBIG2DEC_SITE = \
	https://github.com/ArtifexSoftware/jbig2dec/releases/download/$(JBIG2DEC_VERSION)
JBIG2DEC_LICENSE = AGPL-3.0+
JBIG2DEC_LICENSE_FILES = LICENSE
JBIG2DEC_CPE_ID_VENDOR = artifex
JBIG2DEC_INSTALL_STAGING = YES

# 0001-Bug-705041-jbig2dec-Avoid-uninitialized-allocator-in.patch
JBIG2DEC_IGNORE_CVES += CVE-2023-46361

$(eval $(autotools-package))
