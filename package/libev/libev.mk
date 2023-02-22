################################################################################
#
# libev
#
################################################################################

LIBEV_VERSION = 4.33
LIBEV_SITE = http://dist.schmorp.de/libev/Attic
LIBEV_INSTALL_STAGING = YES
LIBEV_LICENSE = BSD-2-Clause or GPL-2.0+
LIBEV_LICENSE_FILES = LICENSE

# libev has some assembly function that is not present in Thumb mode:
# Error: selected processor does not support `mcr p15,0,r3,c7,c10,5' in Thumb mode
# so, we desactivate Thumb mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
LIBEV_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -marm"
endif

# The 'compatibility' event.h header conflicts with libevent
# It's completely unnecessary for BR packages so remove it
define LIBEV_DISABLE_EVENT_H_INSTALL
	$(SED) 's/ event.h//' $(@D)/Makefile.in
endef
LIBEV_POST_PATCH_HOOKS += LIBEV_DISABLE_EVENT_H_INSTALL

$(eval $(autotools-package))
$(eval $(host-autotools-package))
