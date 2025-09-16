################################################################################
#
# cloudflared
#
################################################################################

CLOUDFLARED_VERSION = 2025.8.1
CLOUDFLARED_SITE = $(call github,cloudflare,cloudflared,$(CLOUDFLARED_VERSION))
CLOUDFLARED_LICENSE = Apache-2.0
CLOUDFLARED_LICENSE_FILES = LICENSE
CLOUDFLARED_CPE_ID_VENDOR = cloudflare
CLOUDFLARED_BUILD_TARGETS = cmd/cloudflared
CLOUDFLARED_LDFLAGS = \
	-X main.Version=$(CLOUDFLARED_VERSION) \
	-X github.com/cloudflare/cloudflared/cmd/cloudflared/updater.BuiltForPackageManager=buildroot

$(eval $(golang-package))
