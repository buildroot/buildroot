################################################################################
#
# jbig2dec
#
################################################################################

JBIG2DEC_VERSION = 0.19
JBIG2DEC_SITE = \
	https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9530
JBIG2DEC_LICENSE = AGPL-3.0+
JBIG2DEC_LICENSE_FILES = LICENSE
JBIG2DEC_CPE_ID_VENDOR = artifex
JBIG2DEC_INSTALL_STAGING = YES
# tarball is missing install-sh, install.sh, or shtool
JBIG2DEC_AUTORECONF = YES

# 0001-Bug-705041-jbig2dec-Avoid-uninitialized-allocator-in.patch
JBIG2DEC_IGNORE_CVES += CVE-2023-46361

$(eval $(autotools-package))
