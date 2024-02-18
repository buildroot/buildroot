################################################################################
#
# sysstat
#
################################################################################

SYSSTAT_VERSION = 12.7.5
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VERSION).tar.xz
SYSSTAT_SITE = https://sysstat.github.io/sysstat-packages
SYSSTAT_CONF_OPTS = --disable-file-attr
SYSSTAT_DEPENDENCIES = host-gettext $(TARGET_NLS_DEPENDENCIES)
SYSSTAT_LICENSE = GPL-2.0+
SYSSTAT_LICENSE_FILES = COPYING
SYSSTAT_CPE_ID_VALID = YES
SYSSTAT_SELINUX_MODULES = sysstat

ifeq ($(BR2_PACKAGE_LM_SENSORS),y)
SYSSTAT_DEPENDENCIES += lm-sensors
SYSSTAT_CONF_OPTS += --enable-sensors
else
SYSSTAT_CONF_OPTS += --disable-sensors
endif
# do not look at host's /usr/lib64
SYSSTAT_CONF_OPTS += sa_lib_dir=/usr/lib/sa

$(eval $(autotools-package))
