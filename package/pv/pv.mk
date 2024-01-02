################################################################################
#
# pv
#
################################################################################

PV_VERSION = 1.8.5
PV_SITE = http://www.ivarch.com/programs/sources
PV_LICENSE = GPL-3.0+
PV_LICENSE_FILES = docs/COPYING
PV_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)

$(eval $(autotools-package))
