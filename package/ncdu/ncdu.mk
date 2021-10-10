################################################################################
#
# ncdu
#
################################################################################

NCDU_VERSION = 1.16
NCDU_SITE = http://dev.yorhel.nl/download

NCDU_DEPENDENCIES = ncurses

NCDU_LICENSE = MIT
NCDU_LICENSE_FILES = COPYING

$(eval $(autotools-package))
