################################################################################
#
# dht
#
################################################################################

DHT_VERSION = 0.27
DHT_SITE = $(call github,jech,dht,dht-$(DHT_VERSION))
DHT_LICENSE = MIT
DHT_LICENSE_FILES = LICENCE
DHT_INSTALL_STAGING = YES

$(eval $(cmake-package))
