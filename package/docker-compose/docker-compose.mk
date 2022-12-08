################################################################################
#
# docker-compose
#
################################################################################

DOCKER_COMPOSE_VERSION = 2.14.0
DOCKER_COMPOSE_SITE = $(call github,docker,compose,v$(DOCKER_COMPOSE_VERSION))
DOCKER_COMPOSE_LICENSE = Apache-2.0
DOCKER_COMPOSE_LICENSE_FILES = LICENSE

DOCKER_COMPOSE_BUILD_TARGETS = cmd
DOCKER_COMPOSE_GOMOD = github.com/docker/compose/v2
DOCKER_COMPOSE_LDFLAGS = \
	-X github.com/docker/compose/v2/internal.Version=$(DOCKER_COMPOSE_VERSION)

define DOCKER_COMPOSE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/bin/cmd \
		$(TARGET_DIR)/usr/lib/docker/cli-plugins/docker-compose
endef

$(eval $(golang-package))
