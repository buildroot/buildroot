################################################################################
#
# speexdsp
#
################################################################################

SPEEXDSP_VERSION = 1.2.1
SPEEXDSP_SITE = https://downloads.xiph.org/releases/speex
SPEEXDSP_LICENSE = BSD-3-Clause
SPEEXDSP_LICENSE_FILES = COPYING
SPEEXDSP_INSTALL_STAGING = YES
SPEEXDSP_DEPENDENCIES = host-pkgconf

$(eval $(autotools-package))
