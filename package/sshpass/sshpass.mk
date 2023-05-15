################################################################################
#
# sshpass
#
################################################################################

SSHPASS_VERSION = 1.10
SSHPASS_SITE = http://downloads.sourceforge.net/project/sshpass/sshpass/$(SSHPASS_VERSION)
SSHPASS_LICENSE = GPL-2.0+
SSHPASS_LICENSE_FILES = COPYING

$(eval $(autotools-package))
