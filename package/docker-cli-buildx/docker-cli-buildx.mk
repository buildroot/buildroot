################################################################################
#
# docker-cli-buildx
#
################################################################################

DOCKER_CLI_BUILDX_VERSION = 0.16.1
DOCKER_CLI_BUILDX_SITE = $(call github,docker,buildx,v$(DOCKER_CLI_BUILDX_VERSION))

DOCKER_CLI_BUILDX_LICENSE = Apache-2.0
DOCKER_CLI_BUILDX_LICENSE_FILES = LICENSE

DOCKER_CLI_BUILDX_DEPENDENCIES = host-pkgconf

DOCKER_CLI_BUILDX_BUILD_TARGETS = cmd/buildx
DOCKER_CLI_BUILDX_GOMOD = github.com/docker/buildx

DOCKER_CLI_BUILDX_LDFLAGS = \
	-X $(DOCKER_CLI_BUILDX_GOMOD)/version.Revision=$(DOCKER_CLI_BUILDX_VERSION) \
	-X $(DOCKER_CLI_BUILDX_GOMOD)/version.Version=$(DOCKER_CLI_BUILDX_VERSION)

define DOCKER_CLI_BUILDX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bin/buildx \
		$(TARGET_DIR)/usr/lib/docker/cli-plugins/docker-buildx
endef

$(eval $(golang-package))
