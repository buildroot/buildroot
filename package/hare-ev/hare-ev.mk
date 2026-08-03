################################################################################
#
# hare-ev
#
################################################################################

HARE_EV_VERSION = 0.26.0.0
HARE_EV_SITE_METHOD = git
HARE_EV_SITE = https://git.sr.ht/~sircmpwn/hare-ev
HARE_EV_LICENSE = MPL-2.0
HARE_EV_LICENSE_FILES = COPYING
HARE_EV_INSTALL_STAGING = YES

$(eval $(hare-package))
