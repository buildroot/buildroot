################################################################################
#
# phidgetwebservice
#
################################################################################

PHIDGETWEBSERVICE_VERSION = 2.1.9.20190409
PHIDGETWEBSERVICE_SOURCE = phidgetwebservice_$(PHIDGETWEBSERVICE_VERSION).tar.gz
PHIDGETWEBSERVICE_SITE = https://www.phidgets.com/downloads/phidget21/servers/linux/phidgetwebservice
PHIDGETWEBSERVICE_DEPENDENCIES = libphidget
PHIDGETWEBSERVICE_LICENSE = LGPL-3.0
PHIDGETWEBSERVICE_LICENSE_FILES = COPYING

$(eval $(autotools-package))
