################################################################################
#
# rtmessage
#
################################################################################

RTMESSAGE_VERSION = 94efc5bdf544b015fad9a8928e535a00ad59549d
RTMESSAGE_SITE_METHOD = git
RTMESSAGE_SITE = https://code.rdkcentral.com/r/rdk/components/opensource/rtmessage
RTMESSAGE_INSTALL_STAGING = YES
RTMESSAGE_AUTORECONF = YES

RTMESSAGE_DEPENDENCIES = cjson
RTMESSAGE_CONF_OPTS += \
    -DRDKC_BUILD=OFF \
    -DENABLE_RDKLOGGER=OFF \
    -DBUILD_DATAPROVIDER_LIB=OFF \
    -DBUILD_DMCLI=OFF \
    -DBUILD_DMCLI_SAMPLE_APP=OFF


$(eval $(cmake-package))
