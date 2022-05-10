################################################################################
#
# alexa-pryon-kwd
#
################################################################################
ALEXA_PRYON_KWD_VERSION = 7327f5ed7fb9372c9ba70c2bf3257f8c68831575
ALEXA_PRYON_KWD_SITE = git@github.com:Metrological/alexa-pryon-kwd.git
ALEXA_PRYON_KWD_SITE_METHOD = git
ALEXA_PRYON_KWD_LICENSE = Proprietary
ALEXA_PRYON_KWD_LICENSE_FILES = LICENSE.txt
ALEXA_PRYON_KWD_INSTALL_STAGING = YES
# dependency to ensure that WPEFRAMEWORK_DATA_PATH is set
ALEXA_PRYON_KWD_DEPENDENCIES = wpeframework

ALEXA_PRYON_KWD_CONF_OPTS += -DALEXA_PRYON_KWD_AVS_DATAPATH="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DATA_PATH))/AVS/"
ALEXA_PRYON_KWD_CONF_OPTS += -DALEXA_PRYON_KWD_PLATFORM=${BR2_PACKAGE_ALEXA_PRYON_KWD_PLATFORM}

ALEXA_PRYON_KWD_POST_INSTALL_TARGET_HOOKS += REMOVE_HEADERS_FROM_TARGET
define REMOVE_HEADERS_FROM_TARGET
	rm -rf ${TARGET_DIR}/usr/include/pryon_lite
endef

$(eval $(cmake-package))
