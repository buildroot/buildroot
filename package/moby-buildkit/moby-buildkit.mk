################################################################################
#
# moby-buildkit
#
################################################################################

MOBY_BUILDKIT_VERSION = 0.11.6
MOBY_BUILDKIT_SITE = $(call github,moby,buildkit,v$(MOBY_BUILDKIT_VERSION))
MOBY_BUILDKIT_LICENSE = Apache-2.0
MOBY_BUILDKIT_LICENSE_FILES = LICENSE

MOBY_BUILDKIT_GOMOD = github.com/moby/buildkit

MOBY_BUILDKIT_TAGS = cgo
MOBY_BUILDKIT_BUILD_TARGETS = cmd/buildctl cmd/buildkitd

MOBY_BUILDKIT_LDFLAGS = \
	-X $(MOBY_BUILDKIT_GOMOD)/version.Version="$(MOBY_BUILDKIT_VERSION)"

MOBY_BUILDKIT_INSTALL_BINS = $(notdir $(MOBY_BUILDKIT_BUILD_TARGETS))

HOST_MOBY_BUILDKIT_TAGS = cgo
HOST_MOBY_BUILDKIT_BUILD_TARGETS = cmd/buildctl cmd/buildkitd

HOST_MOBY_BUILDKIT_INSTALL_BINS = $(notdir $(HOST_MOBY_BUILDKIT_BUILD_TARGETS))

$(eval $(golang-package))
$(eval $(host-golang-package))
