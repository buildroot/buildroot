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
TINYALSA_CONF_OPTS = -Ddocs=disabled -Dexamples=disabled -Dutils=disabled

$(eval $(meson-package))
