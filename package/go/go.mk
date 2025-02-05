################################################################################
#
# go
#
################################################################################

GO_VERSION = 1.23.6

HOST_GO_GOPATH = $(HOST_DIR)/share/go-path
HOST_GO_HOST_CACHE = $(HOST_DIR)/share/host-go-cache
HOST_GO_ROOT = $(HOST_DIR)/lib/go
HOST_GO_TARGET_CACHE = $(HOST_DIR)/share/go-cache

# We pass an empty GOBIN, otherwise "go install: cannot install
# cross-compiled binaries when GOBIN is set"
HOST_GO_COMMON_ENV = \
	GO111MODULE=on \
	GOFLAGS=-mod=vendor \
	GOROOT="$(HOST_GO_ROOT)" \
	GOPATH="$(HOST_GO_GOPATH)" \
	GOCACHE="$(HOST_GO_TARGET_CACHE)" \
	GOMODCACHE="$(HOST_GO_GOPATH)/pkg/mod" \
	GOPROXY=off \
	GOTOOLCHAIN=local \
	PATH=$(BR_PATH) \
	GOBIN= \
	CGO_ENABLED=$(HOST_GO_CGO_ENABLED)

ifeq ($(BR2_PACKAGE_HOST_GO_TARGET_ARCH_SUPPORTS),y)

ifeq ($(BR2_arm),y)
GO_GOARCH = arm
ifeq ($(BR2_ARM_CPU_ARMV5),y)
GO_GOARM = 5
else ifeq ($(BR2_ARM_CPU_ARMV6),y)
GO_GOARM = 6
else ifeq ($(BR2_ARM_CPU_ARMV7A),y)
GO_GOARM = 7
else ifeq ($(BR2_ARM_CPU_ARMV8A),y)
# Go doesn't support 32-bit GOARM=8 (https://github.com/golang/go/issues/29373)
# but can still benefit from armv7 optimisations
GO_GOARM = 7
endif
else ifeq ($(BR2_aarch64),y)
GO_GOARCH = arm64
else ifeq ($(BR2_i386),y)
GO_GOARCH = 386
# i386: use softfloat if no SSE2: https://golang.org/doc/go1.16#386
ifneq ($(BR2_X86_CPU_HAS_SSE2),y)
GO_GO386 = softfloat
endif
else ifeq ($(BR2_x86_64),y)
GO_GOARCH = amd64
else ifeq ($(BR2_powerpc64),y)
GO_GOARCH = ppc64
else ifeq ($(BR2_powerpc64le),y)
GO_GOARCH = ppc64le
else ifeq ($(BR2_mips64),y)
GO_GOARCH = mips64
else ifeq ($(BR2_mips64el),y)
GO_GOARCH = mips64le
else ifeq ($(BR2_riscv),y)
GO_GOARCH = riscv64
else ifeq ($(BR2_s390x),y)
GO_GOARCH = s390x
endif

# For the convenience of target packages.
HOST_GO_TOOLDIR = $(HOST_GO_ROOT)/pkg/tool/linux_$(GO_GOARCH)
HOST_GO_TARGET_ENV = \
	$(HOST_GO_COMMON_ENV) \
	GOOS="linux" \
	GOARCH=$(GO_GOARCH) \
	$(if $(GO_GO386),GO386=$(GO_GO386)) \
	$(if $(GO_GOARM),GOARM=$(GO_GOARM)) \
	CC="$(TARGET_CC)" \
	CXX="$(TARGET_CXX)" \
	CGO_CFLAGS="$(TARGET_CFLAGS)" \
	CGO_CXXFLAGS="$(TARGET_CXXFLAGS)" \
	CGO_LDFLAGS="$(TARGET_LDFLAGS)" \
	GOTOOLDIR="$(HOST_GO_TOOLDIR)"

# Allow packages to use cgo support if it is available for the target. They
# will need the toolchain for cgo support; for convenence, include that
# dependency here.
#
# Note that any target package needing cgo support must include 'depends on
# BR2_PACKAGE_HOST_GO_TARGET_CGO_LINKING_SUPPORTS' in its config file.
ifeq ($(BR2_PACKAGE_HOST_GO_TARGET_CGO_LINKING_SUPPORTS),y)
HOST_GO_DEPENDENCIES_CGO += toolchain
HOST_GO_CGO_ENABLED = 1
else
HOST_GO_CGO_ENABLED = 0
endif
else # !BR2_PACKAGE_HOST_GO_TARGET_ARCH_SUPPORTS
ifeq ($(BR2_PACKAGE_HOST_GO_HOST_CGO_LINKING_SUPPORTS),y)
HOST_GO_CGO_ENABLED = 1
else # !BR2_PACKAGE_HOST_GO_HOST_CGO_LINKING_SUPPORTS
HOST_GO_CGO_ENABLED = 0
endif # BR2_PACKAGE_HOST_GO_HOST_CGO_LINKING_SUPPORTS
endif # BR2_PACKAGE_HOST_GO_TARGET_ARCH_SUPPORTS
# Ensure the toolchain is available, whatever the provider
HOST_GO_DEPENDENCIES += $(HOST_GO_DEPENDENCIES_CGO)

# For the convenience of host golang packages
HOST_GO_HOST_ENV = \
	$(HOST_GO_COMMON_ENV) \
	GOOS="" \
	GOARCH="" \
	GOCACHE="$(HOST_GO_HOST_CACHE)" \
	CC="$(HOSTCC_NOCCACHE)" \
	CXX="$(HOSTCXX_NOCCACHE)" \
	CGO_CFLAGS="$(HOST_CFLAGS)" \
	CGO_CXXFLAGS="$(HOST_CXXFLAGS)" \
	CGO_LDFLAGS="$(HOST_LDFLAGS)"

define GO_BINARIES_INSTALL
	$(INSTALL) -D -m 0755 $(@D)/bin/go $(HOST_GO_ROOT)/bin/go
	$(INSTALL) -D -m 0755 $(@D)/bin/gofmt $(HOST_GO_ROOT)/bin/gofmt

	mkdir -p $(HOST_DIR)/bin
	ln -sf ../lib/go/bin/go $(HOST_DIR)/bin/
	ln -sf ../lib/go/bin/gofmt $(HOST_DIR)/bin/

	cp -a $(@D)/lib $(HOST_GO_ROOT)/

	mkdir -p $(HOST_GO_ROOT)/pkg
	cp -a $(@D)/pkg/include $(HOST_GO_ROOT)/pkg/
	cp -a $(@D)/pkg/tool $(HOST_GO_ROOT)/pkg/

	# The Go sources must be installed to the host/ tree for the Go stdlib.
	cp -a $(@D)/src $(HOST_GO_ROOT)/

	# Set file timestamps to prevent the Go compiler from rebuilding the stdlib
	# when compiling other programs.
	find $(HOST_GO_ROOT) -type f -exec touch -r $(@D)/bin/go {} \;
endef

$(eval $(host-virtual-package))

include $(sort $(wildcard package/go/*/*.mk))
