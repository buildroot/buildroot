################################################################################
#
# bvi
#
################################################################################

BVI_VERSION = 1.5.0
BVI_SITE = https://sourceforge.net/projects/bvi/files/bvi/$(BVI_VERSION)
BVI_SOURCE = bvi-$(BVI_VERSION).src.tar.gz
BVI_LICENSE = GPL-3.0+
BVI_LICENSE_FILES = COPYING
BVI_DEPENDENCIES = ncurses

$(eval $(autotools-package))
