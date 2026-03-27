################################################################################
#
# rwmem
#
################################################################################

RWMEM_VERSION = 2.0
RWMEM_SITE = $(call github,tomba,rwmem,$(RWMEM_VERSION))
RWMEM_LICENSE = GPL-2.0
RWMEM_LICENSE_FILES = LICENSE
RWMEM_DEPENDENCIES = host-pkgconf fmt inih

$(eval $(meson-package))
