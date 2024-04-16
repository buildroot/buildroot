################################################################################
#
# tinyalsa
#
################################################################################

TINYALSA_VERSION = 2.0.0
TINYALSA_SITE = $(call github,tinyalsa,tinyalsa,v$(TINYALSA_VERSION))
TINYALSA_LICENSE = BSD-3-Clause
TINYALSA_LICENSE_FILES = NOTICE
TINYALSA_INSTALL_STAGING = YES
TINYALSA_CONF_OPTS = -Ddocs=disabled -Dexamples=disabled

ifeq ($(BR2_PACKAGE_TINYALSA_TOOLS),y)
TINYALSA_CONF_OPTS += -Dutils=enabled
else
TINYALSA_CONF_OPTS += -Dutils=disabled
endif

$(eval $(meson-package))
