################################################################################
#
# openlayers
#
################################################################################

OPENLAYERS_VERSION = 7.3.0
OPENLAYERS_SOURCE = v$(OPENLAYERS_VERSION)-package.zip
OPENLAYERS_SITE = https://github.com/openlayers/openlayers/releases/download/v$(OPENLAYERS_VERSION)
OPENLAYERS_LICENSE = BSD-2-Clause
OPENLAYERS_LICENSE_FILES = LICENSE.md

define OPENLAYERS_EXTRACT_CMDS
	unzip $(OPENLAYERS_DL_DIR)/$(OPENLAYERS_SOURCE) -d $(@D)
endef

define OPENLAYERS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/ol.css $(TARGET_DIR)/var/www/ol.css
	$(INSTALL) -D -m 0644 $(@D)/dist/ol.js $(TARGET_DIR)/var/www/ol.js
endef

$(eval $(generic-package))
