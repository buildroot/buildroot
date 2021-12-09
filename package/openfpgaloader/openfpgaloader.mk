################################################################################
#
# openfpgaloader
#
################################################################################

OPENFPGALOADER_VERSION = 0.6.1
OPENFPGALOADER_SITE = $(call github,trabucayre,openFPGALoader,v$(OPENFPGALOADER_VERSION))
OPENFPGALOADER_LICENSE = Apache-2.0
OPENFPGALOADER_LICENSE_FILES = LICENSE
OPENFPGALOADER_DEPENDENCIES = libftdi1 zlib

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
OPENFPGALOADER_DEPENDENCIES += udev
OPENFPGALOADER_CONF_OPTS += -DENABLE_UDEV=ON
else
OPENFPGALOADER_CONF_OPTS += -DENABLE_UDEV=OFF
endif

ifeq ($(BR2_PACAKGE_OPENFPGALOADER_CMSIS),y)
OPENFPGALOADER_DEPENDENCIES += hidapi
OPENFPGALOADER_CONF_OPTS += -DENABLE_CMSISDAP=ON
else
OPENFPGALOADER_CONF_OPTS += -DENABLE_CMSISDAP=OFF
endif

$(eval $(cmake-package))
