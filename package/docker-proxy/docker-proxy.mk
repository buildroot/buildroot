################################################################################
#
# docker-proxy
#
################################################################################

DOCKER_PROXY_VERSION = 339b972b464ee3d401b5788b2af9e31d09d6b7da
DOCKER_PROXY_SITE = $(call github,docker,libnetwork,$(DOCKER_PROXY_VERSION))

DOCKER_PROXY_LICENSE = Apache-2.0
DOCKER_PROXY_LICENSE_FILES = LICENSE

DOCKER_PROXY_DEPENDENCIES = host-pkgconf

DOCKER_PROXY_BUILD_TARGETS = cmd/proxy

define DOCKER_PROXY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/proxy $(TARGET_DIR)/usr/bin/docker-proxy
endef

$(eval $(golang-package))
