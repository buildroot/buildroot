################################################################################
#
# docker-cli-buildx
#
################################################################################

DOCKER_CLI_BUILDX_VERSION = 0.11.2
DOCKER_CLI_BUILDX_SITE = $(call github,docker,buildx,v$(DOCKER_CLI_BUILDX_VERSION))

DOCKER_CLI_BUILDX_LICENSE = Apache-2.0
DOCKER_CLI_BUILDX_LICENSE_FILES = LICENSE

DOCKER_CLI_BUILDX_DEPENDENCIES = host-pkgconf

DOCKER_CLI_BUILDX_BUILD_TARGETS = cmd/buildx
DOCKER_CLI_BUILDX_GOMOD = github.com/docker/buildx

DOCKER_CLI_BUILDX_LDFLAGS = \
	-X $(DOCKER_CLI_BUILDX_GOMOD)/version.Revision=$(DOCKER_CLI_BUILDX_VERSION) \
	-X $(DOCKER_CLI_BUILDX_GOMOD)/version.Version=$(DOCKER_CLI_BUILDX_VERSION)

# create the go.mod file with required language version go1.20
# remove the conflicting vendor/modules.txt
# https://github.com/moby/moby/issues/44618#issuecomment-1343565705
define DOCKER_CLI_BUILDX_FIX_VENDORING
	printf "module $(DOCKER_CLI_BUILDX_GOMOD)\n\ngo 1.20\n" > $(@D)/go.mod
	rm -f $(@D)/vendor/modules.txt
endef
DOCKER_CLI_BUILDX_POST_EXTRACT_HOOKS += DOCKER_CLI_BUILDX_FIX_VENDORING

define DOCKER_CLI_BUILDX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bin/buildx \
		$(TARGET_DIR)/usr/lib/docker/cli-plugins/docker-buildx
endef

$(eval $(golang-package))
