################################################################################
#
# rwmem
#
################################################################################

RWMEM_VERSION = c8291705c82bb0686be9adf6a427a2b72114719a
RWMEM_SITE = $(call github,tomba,rwmem,$(RWMEM_VERSION))
RWMEM_LICENSE = GPL-2.0
RWMEM_LICENSE_FILES = LICENSE
RWMEM_CONF_OPTS = -Dpyrwmem=disabled
RWMEM_DEPENDENCIES = host-pkgconf fmt inih

$(eval $(meson-package))
