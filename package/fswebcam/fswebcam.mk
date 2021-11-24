################################################################################
#
# fswebcam
#
################################################################################

FSWEBCAM_VERSION = 20200725
FSWEBCAM_SITE = $(call github,fsphil,fswebcam,$(FSWEBCAM_VERSION))
FSWEBCAM_LICENSE = GPL-2.0
FSWEBCAM_LICENSE_FILES = LICENSE

FSWEBCAM_DEPENDENCIES += freetype jpeg libpng gd

$(eval $(autotools-package))
