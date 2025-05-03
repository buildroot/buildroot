################################################################################
#
# m4
#
################################################################################

M4_VERSION = 1.4.19
M4_SOURCE = m4-$(M4_VERSION).tar.xz
M4_SITE = $(BR2_GNU_MIRROR)/m4
M4_LICENSE = GPL-3.0+
M4_LICENSE_FILES = COPYING

# gcc-15 defaults to -std=gnu23 which is incorrectly detected and
# generates build failures in the gnulib copy included in
# m4-1.4.19. We workaround this by forcing the previous gcc default
# standard, which is -std=gnu17 only when host gcc is >= 15. This
# workaround can be removed when m4 will be updated to a version
# including a fix for gcc-15.
ifeq ($(BR2_HOST_GCC_AT_LEAST_15),y)
HOST_M4_CONF_ENV = CFLAGS="$(HOST_CFLAGS) -std=gnu17"
endif

$(eval $(host-autotools-package))
