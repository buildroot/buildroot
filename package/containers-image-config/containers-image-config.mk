################################################################################
#
# containers-image-config
#
################################################################################

CONTAINERS_IMAGE_CONFIG_VERSION = v5.35.0
CONTAINERS_IMAGE_CONFIG_SITE = https://github.com/containers/image
CONTAINERS_IMAGE_CONFIG_SITE_METHOD = git

CONTAINERS_IMAGE_CONFIG_LICENSE = Apache-2.0
CONTAINERS_IMAGE_CONFIG_LICENSE_FILES = LICENSE

define CONTAINERS_IMAGE_CONFIG_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 \
		$(@D)/default-policy.json \
		$(TARGET_DIR)/etc/containers/policy.json
	$(INSTALL) -D -m 0644 \
		$(@D)/registries.conf \
		$(TARGET_DIR)/etc/containers/registries.conf
	$(SED) '/^# unqualified-search-registries = .*/s//unqualified-search-registries = ["docker.io"]/' \
		$(TARGET_DIR)/etc/containers/registries.conf
endef

$(eval $(generic-package))
