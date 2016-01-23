################################################################################
#
# tditracer
#
################################################################################

TDITRACER_VERSION = f2cb119c5b055385fdedb75026b136a19b5f7cfc
TDITRACER_SITE = $(call github,robvogelaar,tditracer,$(TDITRACER_VERSION))

TDITRACER_INSTALL_STAGING = YES
TDITRACER_LICENSE = GPL

TDITRACER_AUTORECONF = YES

$(eval $(autotools-package))
