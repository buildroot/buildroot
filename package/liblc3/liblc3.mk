################################################################################
#
# liblc3
#
################################################################################

LIBLC3_VERSION = 1.1.3
LIBLC3_SITE = $(call github,google,liblc3,v$(LIBLC3_VERSION))
LIBLC3_LICENSE = Apache-2.0
LIBLC3_LICENSE_FILES = LICENSE
LIBLC3_INSTALL_STAGING = YES
LIBLC3_CONF_OPTS = \
	-Dpython=false \
	-Dtools=false

$(eval $(meson-package))
