################################################################################
#
# rbus
#
################################################################################

RBUS_VERSION = 0e79c34e5faae52f77e7a196c5eae7595c1cdca4
RBUS_SITE_METHOD = git
RBUS_SITE = https://code.rdkcentral.com/r/components/opensource/rbus
RBUS_INSTALL_STAGING = YES
RBUS_AUTORECONF = YES
RBUS_DEPENDENCIES = rbus-core linenoise

$(eval $(cmake-package))
