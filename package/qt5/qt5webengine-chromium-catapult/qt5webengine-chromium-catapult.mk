################################################################################
#
# qt5webengine-chromium-catapult
#
################################################################################

QT5WEBENGINE_CHROMIUM_CATAPULT_VERSION = 7534569f99827c0ed4df818254ba7daca4606bca
QT5WEBENGINE_CHROMIUM_CATAPULT_SITE = https://chromium.googlesource.com/catapult.git
QT5WEBENGINE_CHROMIUM_CATAPULT_SITE_METHOD = git
QT5WEBENGINE_CHROMIUM_CATAPULT_LICENSE = BSD-3-Clause
QT5WEBENGINE_CHROMIUM_CATAPULT_LICENSE_FILES = LICENSE
QT5WEBENGINE_CHROMIUM_CATAPULT_INSTALL_TARGET = NO

$(eval $(generic-package))
