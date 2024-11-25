################################################################################
#
# less
#
################################################################################

LESS_VERSION = 661
LESS_SITE = http://www.greenwoodsoftware.com/less
LESS_LICENSE = GPL-3.0+
LESS_LICENSE_FILES = COPYING
LESS_CPE_ID_VENDOR = gnu
LESS_DEPENDENCIES = ncurses

$(eval $(autotools-package))
