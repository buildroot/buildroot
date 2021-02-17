################################################################################
#
# log4qt
#
################################################################################

LOG4QT_VERSION = 1.5.1
LOG4QT_SITE = $(call github,MEONMedical,Log4Qt,v$(LOG4QT_VERSION))
LOG4QT_DEPENDENCIES = qt5base
LOG4QT_LICENSE = Apache-2.0
LOG4QT_LICENSE_FILES = LICENSE
LOG4QT_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5BASE_SQLITE_QT)$(BR2_PACKAGE_QT5BASE_SQLITE_SYSTEM),y)
LOG4QT_CONF_OPTS += -DBUILD_WITH_DB_LOGGING=ON
else
LOG4QT_CONF_OPTS += -DBUILD_WITH_DB_LOGGING=OFF
endif

$(eval $(cmake-package))
