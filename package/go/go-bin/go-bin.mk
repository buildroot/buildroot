################################################################################
#
# go-bin
#
################################################################################

GO_BIN_VERSION = $(GO_VERSION)
GO_BIN_SITE = https://go.dev/dl
GO_BIN_SOURCE = go$(GO_VERSION).linux-$(call qstrip, $(BR2_PACKAGE_HOST_GO_BIN_HOST_ARCH)).tar.gz
GO_BIN_DL_SUBDIR = go
HOST_GO_BIN_ACTUAL_SOURCE_TARBALL = go$(GO_VERSION).src.tar.gz
GO_BIN_LICENSE = BSD-3-Clause
GO_BIN_LICENSE_FILES = LICENSE
GO_BIN_CPE_ID_VENDOR = golang
GO_BIN_CPE_ID_PRODUCT = go

HOST_GO_BIN_PROVIDES = host-go

define HOST_GO_BIN_INSTALL_CMDS
	$(GO_BINARIES_INSTALL)
endef

$(eval $(host-generic-package))
