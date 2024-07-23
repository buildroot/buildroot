################################################################################
#
# parsec
#
################################################################################

PARSEC_VERSION = 1.4.1
PARSEC_SITE = $(call github,parallaxsecond,parsec,$(PARSEC_VERSION))
PARSEC_LICENSE = Apache-2.0
PARSEC_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
