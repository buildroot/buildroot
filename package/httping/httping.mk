################################################################################
#
# httping
#
################################################################################

HTTPING_VERSION = a1c5fdcf289cf7d1d8245579150bcf670f90d248
HTTPING_SITE = https://github.com/folkertvanheusden/HTTPing
HTTPING_SITE_METHOD = git
HTTPING_LICENSE = AGPL-3.0
HTTPING_LICENSE_FILES = LICENSE
HTTPING_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_PACKAGE_HTTPING_TUI),y)
HTTPING_DEPENDENCIES += ncurses fftw-double
HTTPING_CONF_OPTS += -DUSE_TUI=ON -DUSE_FFTW3=ON
else
HTTPING_CONF_OPTS += -DUSE_TUI=OFF -DUSE_FFTW3=OFF
endif

ifeq ($(BR2_PACKAGE_HTTPING_SSL),y)
HTTPING_DEPENDENCIES += openssl
HTTPING_CONF_OPTS += -DUSE_SSL=ON
else
HTTPING_CONF_OPTS += -DUSE_SSL=OFF
endif

ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
HTTPING_CONF_OPTS += -DUSE_GETTEXT=ON
else
HTTPING_CONF_OPTS += -DUSE_GETTEXT=OFF
endif

$(eval $(cmake-package))
