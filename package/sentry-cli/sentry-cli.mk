################################################################################
#
# sentry-cli
#
################################################################################

SENTRY_CLI_VERSION = 2.20.3
SENTRY_CLI_SITE = $(call github,getsentry,sentry-cli,$(SENTRY_CLI_VERSION))
SENTRY_CLI_LICENSE = BSD-3-clause
SENTRY_CLI_LICENSE_FILES = LICENSE

HOST_SENTRY_CLI_DEPENDENCIES = host-pkgconf host-openssl host-zlib

$(eval $(host-cargo-package))
