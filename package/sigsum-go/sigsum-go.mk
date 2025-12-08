################################################################################
#
# sigsum-go
#
################################################################################

SIGSUM_GO_VERSION = v0.13.1
SIGSUM_GO_SITE = https://git.glasklar.is/sigsum/core/sigsum-go
SIGSUM_GO_SITE_METHOD = git
SIGSUM_GO_LICENSE = BSD-2-Clause
SIGSUM_GO_LICENSE_FILES = LICENSE

SIGSUM_GO_GOMOD = sigsum.org/sigsum-go

ifeq ($(BR2_PACKAGE_SIGSUM_GO_KEY),y)
SIGSUM_GO_BUILD_TARGETS += cmd/sigsum-key
endif

ifeq ($(BR2_PACKAGE_SIGSUM_GO_POLICY),y)
SIGSUM_GO_BUILD_TARGETS += cmd/sigsum-policy
endif

ifeq ($(BR2_PACKAGE_SIGSUM_GO_SUBMIT),y)
SIGSUM_GO_BUILD_TARGETS += cmd/sigsum-submit
endif

ifeq ($(BR2_PACKAGE_SIGSUM_GO_TOKEN),y)
SIGSUM_GO_BUILD_TARGETS += cmd/sigsum-token
endif

ifeq ($(BR2_PACKAGE_SIGSUM_GO_VERIFY),y)
SIGSUM_GO_BUILD_TARGETS += cmd/sigsum-verify
endif

HOST_SIGSUM_GO_GOMOD = sigsum.org/sigsum-go
HOST_SIGSUM_GO_BUILD_TARGETS = \
	cmd/sigsum-key \
	cmd/sigsum-submit \
	cmd/sigsum-token \
	cmd/sigsum-verify

$(eval $(golang-package))
$(eval $(host-golang-package))
