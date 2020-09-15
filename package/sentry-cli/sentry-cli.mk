################################################################################
#
# sentry-cli
#
################################################################################

SENTRY_CLI_VERSION = 1.57.0
SENTRY_CLI_SITE = $(call github,getsentry,sentry-cli,$(SENTRY_CLI_VERSION))
SENTRY_CLI_LICENSE = BSD-3-clause
SENTRY_CLI_LICENSE_FILES = LICENSE

SENTRY_CLI_DEPENDENCIES = host-rustc

HOST_SENTRY_CLI_CARGO_ENV = CARGO_HOME=$(HOST_DIR)/share/cargo

HOST_SENTRY_CLI_CARGO_OPTS = \
	--release \
	--manifest-path=$(@D)/Cargo.toml

define HOST_SENTRY_CLI_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_SENTRY_CLI_CARGO_ENV) \
		cargo build $(HOST_SENTRY_CLI_CARGO_OPTS)
endef

define HOST_SENTRY_CLI_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/target/release/sentry-cli \
		$(HOST_DIR)/bin/sentry-cli
endef

$(eval $(host-generic-package))
