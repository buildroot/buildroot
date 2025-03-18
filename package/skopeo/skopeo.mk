################################################################################
#
# skopeo
#
################################################################################

SKOPEO_VERSION = 1.18.0
SKOPEO_SITE = $(call github,containers,skopeo,v$(SKOPEO_VERSION))

SKOPEO_LICENSE = Apache-2.0
SKOPEO_LICENSE_FILES = LICENSE
SKOPEO_CPE_ID_VALID = YES

SKOPEO_DEPENDENCIES = \
	host-pkgconf \
	btrfs-progs \
	libgpgme \
	lvm2

HOST_SKOPEO_DEPENDENCIES = \
	host-btrfs-progs \
	host-libgpgme \
	host-lvm2 \
	host-pkgconf

SKOPEO_GO_ENV = PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig
SKOPEO_BUILD_TARGETS = cmd/skopeo

HOST_SKOPEO_GO_ENV = PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig
HOST_SKOPEO_BUILD_TARGETS = cmd/skopeo

$(eval $(golang-package))
$(eval $(host-golang-package))
