################################################################################
#
# speexdsp
#
################################################################################

SPEEXDSP_VERSION = 1.2.0
SPEEXDSP_SOURCE = speexdsp-SpeexDSP-$(SPEEXDSP_VERSION).tar.bz2
SPEEXDSP_SITE = https://gitlab.xiph.org/xiph/speexdsp/-/archive/SpeexDSP-$(SPEEXDSP_VERSION)
SPEEXDSP_LICENSE = BSD-3-Clause
SPEEXDSP_LICENSE_FILES = COPYING
SPEEXDSP_INSTALL_STAGING = YES
SPEEXDSP_DEPENDENCIES = host-pkgconf
SPEEXDSP_AUTORECONF = YES

$(eval $(autotools-package))
