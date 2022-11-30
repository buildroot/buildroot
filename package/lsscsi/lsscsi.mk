################################################################################
#
# lsscsi
#
################################################################################

LSSCSI_VERSION = 0.32
LSSCSI_SOURCE = lsscsi-$(LSSCSI_VERSION).tgz
LSSCSI_SITE = http://sg.danny.cz/scsi
LSSCSI_LICENSE = GPL-2.0+
LSSCSI_LICENSE_FILES = COPYING

$(eval $(autotools-package))
