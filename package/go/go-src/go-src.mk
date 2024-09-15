################################################################################
#
# go-src
#
################################################################################

GO_SRC_SITE = https://storage.googleapis.com/golang
GO_SRC_SOURCE = go$(GO_VERSION).src.tar.gz
GO_SRC_DL_SUBDIR = go

GO_SRC_LICENSE = BSD-3-Clause
GO_SRC_LICENSE_FILES = LICENSE
GO_SRC_CPE_ID_VENDOR = golang

HOST_GO_SRC_PROVIDES = host-go
HOST_GO_SRC_DEPENDENCIES = \
	host-go-bootstrap-stage3 \
	$(HOST_GO_DEPENDENCIES_CGO)

ifeq ($(BR2_PACKAGE_HOST_GO_TARGET_ARCH_SUPPORTS),y)

HOST_GO_SRC_CROSS_ENV = \
	CC_FOR_TARGET="$(TARGET_CC)" \
	CXX_FOR_TARGET="$(TARGET_CXX)" \
	GOOS="linux" \
	GOARCH=$(GO_GOARCH) \
	$(if $(GO_GO386),GO386=$(GO_GO386)) \
	$(if $(GO_GOARM),GOARM=$(GO_GOARM)) \
	GO_ASSUME_CROSSCOMPILING=1

endif

# The go build system is not compatible with ccache, so use
# HOSTCC_NOCCACHE.  See https://github.com/golang/go/issues/11685.
HOST_GO_SRC_MAKE_ENV = \
	GO111MODULE=off \
	GOCACHE=$(HOST_GO_HOST_CACHE) \
	GOROOT_BOOTSTRAP=$(HOST_GO_BOOTSTRAP_STAGE3_ROOT) \
	GOROOT_FINAL=$(HOST_GO_ROOT) \
	GOROOT="$(@D)" \
	GOBIN="$(@D)/bin" \
	GOOS=linux \
	CC=$(HOSTCC_NOCCACHE) \
	CXX=$(HOSTCXX_NOCCACHE) \
	CGO_ENABLED=$(HOST_GO_CGO_ENABLED) \
	$(HOST_GO_SRC_CROSS_ENV)

define HOST_GO_SRC_BUILD_CMDS
	cd $(@D)/src && \
		$(HOST_GO_SRC_MAKE_ENV) ./make.bash $(if $(VERBOSE),-v)
endef

define HOST_GO_SRC_INSTALL_CMDS
	$(GO_BINARIES_INSTALL)
endef

$(eval $(host-generic-package))
