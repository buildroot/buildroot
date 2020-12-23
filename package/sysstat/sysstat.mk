################################################################################
#
# sysstat
#
################################################################################

SYSSTAT_VERSION = 12.4.2
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VERSION).tar.xz
SYSSTAT_SITE = http://pagesperso-orange.fr/sebastien.godard
SYSSTAT_CONF_OPTS = --disable-file-attr --disable-sensors
SYSSTAT_DEPENDENCIES = host-gettext $(TARGET_NLS_DEPENDENCIES)
SYSSTAT_LICENSE = GPL-2.0+
SYSSTAT_LICENSE_FILES = COPYING

$(eval $(autotools-package))
