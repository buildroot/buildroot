################################################################################
#
# mbpoll
#
################################################################################

MBPOLL_VERSION = 1.5
MBPOLL_SITE = $(call github,epsilonrt,mbpoll,v$(MBPOLL_VERSION))
MBPOLL_DEPENDENCIES = host-pkgconf libmodbus
MBPOLL_LICENSE = GPL-3.0+
MBPOLL_LICENSE_FILES = COPYING

$(eval $(cmake-package))
