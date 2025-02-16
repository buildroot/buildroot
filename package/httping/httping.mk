################################################################################
#
# httping
#
################################################################################

HTTPING_VERSION = ffb9201042813c58d020df41697f6445df96f438
HTTPING_SITE = https://github.com/folkertvanheusden/HTTPing
HTTPING_SITE_METHOD = git
HTTPING_LICENSE = AGPL-3.0
HTTPING_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_HTTPING_TUI),y)
HTTPING_DEPENDENCIES += ncurses fftw-double
HTTPING_CONF_OPTS += -DUSE_TUI=1
endif

ifeq ($(BR2_PACKAGE_HTTPING_SSL),y)
HTTPING_DEPENDENCIES += openssl
endif

$(eval $(cmake-package))
