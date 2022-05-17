################################################################################
#
# qt5webengine-chromium-catapult
#
################################################################################

QT5WEBENGINE_CHROMIUM_CATAPULT_VERSION = 5eedfe23148a234211ba477f76fc2ea2e8529189
QT5WEBENGINE_CHROMIUM_CATAPULT_SITE = https://chromium.googlesource.com/catapult.git
QT5WEBENGINE_CHROMIUM_CATAPULT_SITE_METHOD = git
QT5WEBENGINE_CHROMIUM_CATAPULT_LICENSE = BSD-3-Clause
QT5WEBENGINE_CHROMIUM_CATAPULT_LICENSE_FILES = LICENSE
QT5WEBENGINE_CHROMIUM_CATAPULT_INSTALL_TARGET = NO

$(eval $(generic-package))
