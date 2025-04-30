################################################################################
#
# lpac
#
################################################################################

LPAC_VERSION = 2.2.1
LPAC_SITE = $(call github,estkme-group,lpac,v$(LPAC_VERSION))
LPAC_LICENSE = LGPL-2.1+ (library), AGPL-3.0 (programs), MIT (cjson)
LPAC_LICENSE_FILES = src/LICENSE euicc/LICENSE cjson/LICENSE
LPAC_DEPENDENCIES = pcsc-lite

ifeq ($(BR2_PACKAGE_LIBCURL),y)
LPAC_DEPENDENCIES += libcurl
LPAC_CONF_OPTS += -DLPAC_WITH_HTTP_CURL=ON
else
LPAC_CONF_OPTS += -DLPAC_WITH_HTTP_CURL=OFF
endif

ifeq ($(BR2_PACKAGE_LIBQMI),y)
LPAC_DEPENDENCIES += libqmi
LPAC_CONF_OPTS += -DLPAC_WITH_APDU_QMI=ON
else
LPAC_CONF_OPTS += -DLPAC_WITH_APDU_QMI=OFF
endif

ifeq ($(BR2_PACKAGE_LIBQRTR_GLIB),y)
LPAC_DEPENDENCIES += libqmi libqrtr-glib
LPAC_CONF_OPTS += -DLPAC_WITH_APDU_QMI_QRTR=ON
else
LPAC_CONF_OPTS += -DLPAC_WITH_APDU_QMI_QRTR=OFF
endif

ifeq ($(BR2_PACKAGE_LIBMBIM),y)
LPAC_DEPENDENCIES += libmbim
LPAC_CONF_OPTS += -DLPAC_WITH_APDU_MBIM=ON
else
LPAC_CONF_OPTS += -DLPAC_WITH_APDU_MBIM=OFF
endif

$(eval $(cmake-package))
