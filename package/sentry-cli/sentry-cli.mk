################################################################################
#
# sentry-cli
#
################################################################################

SENTRY_CLI_VERSION = 2.8.0
SENTRY_CLI_SITE = $(call github,getsentry,sentry-cli,$(SENTRY_CLI_VERSION))
SENTRY_CLI_LICENSE = BSD-3-clause
SENTRY_CLI_LICENSE_FILES = LICENSE

HOST_SENTRY_CLI_DEPENDENCIES = host-zlib

$(eval $(host-cargo-package))
