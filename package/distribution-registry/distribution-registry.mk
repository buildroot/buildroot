################################################################################
#
# distribution-registry
#
################################################################################

DISTRIBUTION_REGISTRY_VERSION = v3.0.0
DISTRIBUTION_REGISTRY_SITE = https://github.com/distribution/distribution
DISTRIBUTION_REGISTRY_SITE_METHOD = git

DISTRIBUTION_REGISTRY_LICENSE = Apache-2.0
DISTRIBUTION_REGISTRY_LICENSE_FILES = LICENSE

DISTRIBUTION_REGISTRY_GOMOD = github.com/distribution/distribution/v3

DISTRIBUTION_REGISTRY_BUILD_TARGETS = cmd/registry

# distribution-registry builds and installs the 'registry' executable, but
# that name is a bit too generic. Rename it to match the package name.
DISTRIBUTION_REGISTRY_BIN_NAME = distribution-registry
DISTRIBUTION_REGISTRY_INSTALL_BINS = distribution-registry

# Inject the version as if done by upstream's wrapper Makefile
define DISTRIBUTION_REGISTRY_SET_VERSION
	$(SED) 's/^var version = ".*"$$/var version = "$(DISTRIBUTION_REGISTRY_VERSION)"/' \
		$(@D)/version/version.go
endef
DISTRIBUTION_REGISTRY_PRE_CONFIGURE_HOOKS += DISTRIBUTION_REGISTRY_SET_VERSION

define DISTRIBUTION_REGISTRY_CONFIG
	$(INSTALL) -m 0644 -D \
		$(DISTRIBUTION_REGISTRY_PKGDIR)/config.yml \
		$(TARGET_DIR)/etc/docker/registry/config.yml
endef
DISTRIBUTION_REGISTRY_POST_INSTALL_TARGET_HOOKS += DISTRIBUTION_REGISTRY_CONFIG

define DISTRIBUTION_REGISTRY_USERS
	distribution-registry -1 distribution-registry -1 * - - - Distribution registry
endef

define DISTRIBUTION_REGISTRY_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 -D \
		$(DISTRIBUTION_REGISTRY_PKGDIR)/distribution-registry.service \
		$(TARGET_DIR)/usr/lib/systemd/system/distribution-registry.service
endef

$(eval $(golang-package))
