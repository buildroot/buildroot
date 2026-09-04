################################################################################
#
# sentry-cli
#
################################################################################

SENTRY_CLI_VERSION = 3.7.0
SENTRY_CLI_SITE = $(call github,getsentry,sentry-cli,$(SENTRY_CLI_VERSION))
SENTRY_CLI_LICENSE = FSL-1.1-MIT
SENTRY_CLI_LICENSE_FILES = LICENSE

HOST_SENTRY_CLI_DEPENDENCIES = host-pkgconf host-openssl host-zlib

$(eval $(host-cargo-package))
