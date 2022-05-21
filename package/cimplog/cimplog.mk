################################################################################
#
# cimplog
#
################################################################################

CIMPLOG_VERSION = 8b5c60f3930aa287121edd40c97915f692426a61
CIMPLOG_SITE_METHOD = git
CIMPLOG_SITE = https://github.com/Comcast/cimplog.git
CIMPLOG_INSTALL_STAGING = YES

CIMPLOG_CONF_OPTS += -DFEATURE_SUPPORT_ONBOARD_LOGGING=true

$(eval $(cmake-package))
