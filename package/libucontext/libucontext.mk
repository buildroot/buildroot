################################################################################
#
# libucontext
#
################################################################################

LIBUCONTEXT_VERSION = 1.2
LIBUCONTEXT_SITE = $(call github,kaniini,libucontext,libucontext-$(LIBUCONTEXT_VERSION))
LIBUCONTEXT_LICENSE = ISC
LIBUCONTEXT_LICENSE_FILES = LICENSE
LIBUCONTEXT_INSTALL_STAGING = YES

LIBUCONTEXT_CONF_OPTS = \
	-Dfreestanding=false \
	-Dexport_unprefixed=true

$(eval $(meson-package))
