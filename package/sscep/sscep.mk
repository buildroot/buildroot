################################################################################
#
# sscep
#
################################################################################

SSCEP_VERSION = 0.10.0
SSCEP_SITE = $(call github,certnanny,sscep,v$(SSCEP_VERSION))
SSCEP_LICENSE = BSD-2-Clause, OpenSSL, OpenOSP
SSCEP_LICENSE_FILES = COPYING
SSCEP_AUTORECONF = YES
SSCEP_DEPENDENCIES = host-pkgconf openssl

$(eval $(autotools-package))
