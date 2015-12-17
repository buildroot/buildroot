################################################################################
#
# tditracer
#
################################################################################

TDITRACER_VERSION = master
TDITRACER_SITE = git@github.com:robvogelaar/tditracer.git
TDITRACER_SITE_METHOD = git

## TDITRACER_SITE = /home/rev/git/tditracer
## TDITRACER_SITE_METHOD = local

TDITRACER_INSTALL_STAGING = YES
TDITRACER_LICENSE = GPL

TDITRACER_AUTORECONF = YES

$(eval $(autotools-package))
