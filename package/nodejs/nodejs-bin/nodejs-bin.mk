################################################################################
#
# nodejs-bin
#
################################################################################

NODEJS_BIN_VERSION = $(NODEJS_COMMON_VERSION)
NODEJS_BIN_SITE = $(NODEJS_COMMON_SITE)
NODEJS_BIN_SOURCE = node-v$(NODEJS_BIN_VERSION)-linux-$(NODEJS_BIN_ARCH).tar.xz
HOST_NODEJS_BIN_ACTUAL_SOURCE_TARBALL = node-v$(NODEJS_BIN_VERSION).tar.xz
NODEJS_BIN_DL_SUBDIR = nodejs

NODEJS_BIN_LICENSE = $(NODEJS_LICENSE)
NODEJS_BIN_LICENSE_FILES = $(NODEJS_LICENSE_FILES)
NODEJS_BIN_CPE_ID_VENDOR = $(NODEJS_CPE_ID_VENDOR)
NODEJS_BIN_CPE_ID_PRODUCT = $(NODEJS_CPE_ID_PRODUCT)

HOST_NODEJS_BIN_PROVIDES = host-nodejs

ifeq ($(HOSTARCH),aarch64)
NODEJS_BIN_ARCH = arm64
else ifeq ($(HOSTARCH),arm)
# We assume that if someone does a build on ARM, it will be on an
# ARMv7 machine
NODEJS_BIN_ARCH = armv7l
else ifeq ($(HOSTARCH),ppc64le)
NODEJS_BIN_ARCH = ppc64le
else ifeq ($(HOSTARCH),x86_64)
NODEJS_BIN_ARCH = x64
endif

define HOST_NODEJS_BIN_INSTALL_CMDS
	rsync -a --exclude=CHANGELOG.md --exclude=LICENSE --exclude=README.md \
		$(@D)/* $(HOST_DIR)/
endef

$(eval $(host-generic-package))
