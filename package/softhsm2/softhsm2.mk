################################################################################
#
# softhsm2
#
################################################################################

SOFTHSM2_VERSION = 2.6.1
SOFTHSM2_SOURCE = softhsm-$(SOFTHSM2_VERSION).tar.gz
SOFTHSM2_SITE = https://dist.opendnssec.org/source
SOFTHSM2_LICENSE = BSD-2-Clause
SOFTHSM2_LICENSE_FILES = LICENSE
SOFTHSM2_DEPENDENCIES = openssl
SOFTHSM2_INSTALL_STAGING = YES

$(eval $(autotools-package))
