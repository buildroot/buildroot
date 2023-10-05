################################################################################
#
# rwmem
#
################################################################################

RWMEM_VERSION = c89bc9ad9a8f2359f358c510db57b7678eb156d1
RWMEM_SITE = $(call github,tomba,rwmem,$(RWMEM_VERSION))
RWMEM_LICENSE = GPL-2.0
RWMEM_LICENSE_FILES = LICENSE
RWMEM_CONF_OPTS = -Dpyrwmem=disabled
RWMEM_DEPENDENCIES = host-pkgconf fmt inih

$(eval $(meson-package))
