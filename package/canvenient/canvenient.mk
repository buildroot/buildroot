################################################################################
#
# canvenient
#
################################################################################

CANVENIENT_VERSION = 1.02
CANVENIENT_SITE = $(call github,CANopenTerm,CANvenient,v$(CANVENIENT_VERSION))
CANVENIENT_LICENSE = MIT
CANVENIENT_LICENSE_FILES = LICENSE.md
CANVENIENT_INSTALL_STAGING = YES
CANVENIENT_DEPENDENCIES = libsocketcan

$(eval $(cmake-package))
