################################################################################
#
# host-flutter-sdk-bin
#
################################################################################

FLUTTER_SDK_BIN_VERSION = 3.27.1
FLUTTER_SDK_BIN_SITE = https://storage.googleapis.com/flutter_infra_release/releases/stable/linux
FLUTTER_SDK_BIN_SOURCE = flutter_linux_$(FLUTTER_SDK_BIN_VERSION)-stable.tar.xz
FLUTTER_SDK_BIN_LICENSE = BSD-3-Clause
FLUTTER_SDK_BIN_LICENSE_FILES = LICENSE

HOST_FLUTTER_SDK_BIN_SDK = $(HOST_DIR)/share/flutter/sdk
HOST_FLUTTER_SDK_BIN_DART_SDK = $(HOST_FLUTTER_SDK_BIN_SDK)/bin/cache/dart-sdk
HOST_FLUTTER_SDK_BIN_SDK_ENGINE = $(HOST_FLUTTER_SDK_BIN_SDK)/bin/cache/artifacts/engine

# We must set the home directory to the sdk directory or else flutter will
# place .dart, .dart-sdk, and .flutter in ~/.
HOST_FLUTTER_SDK_BIN_ENV = \
	HOME=$(HOST_FLUTTER_SDK_BIN_SDK) \
	PATH=$(BR_PATH):$(HOST_FLUTTER_SDK_BIN_SDK):$(HOST_FLUTTER_SDK_BIN_SDK)/bin \
	PUB_CACHE=$(FLUTTER_SDK_BIN_PUB_CACHE)

# The following config options must be ran one at a time.
HOST_FLUTTER_SDK_BIN_CONF_OPTS = \
	--clear-features \
	--no-analytics \
	--disable-analytics \
	--enable-custom-devices \
	--enable-linux-desktop \
	--no-enable-android \
	--no-enable-fuchsia \
	--no-enable-ios \
	--no-enable-macos-desktop \
	--no-enable-windows-desktop

define HOST_FLUTTER_SDK_BIN_CONFIGURE_CMDS
	$(foreach i,$(HOST_FLUTTER_SDK_BIN_CONF_OPTS),
		$(HOST_FLUTTER_SDK_BIN_ENV) $(@D)/bin/flutter config $(i); \
	)
	$(HOST_FLUTTER_SDK_BIN_ENV) $(@D)/bin/dart --disable-analytics
endef

define HOST_FLUTTER_SDK_BIN_BUILD_CMDS
	mkdir -p $(HOST_FLUTTER_SDK_BIN_SDK)
	cd $(@D) && \
		$(HOST_FLUTTER_SDK_BIN_ENV) $(@D)/bin/flutter precache;
endef

define HOST_FLUTTER_SDK_BIN_INSTALL_CMDS
	cp -rpdT $(@D)/. $(HOST_FLUTTER_SDK_BIN_SDK)/
endef

ifeq ($(FLUTTER_ENGINE_RUNTIME_MODE_PROFILE),y)
HOST_FLUTTER_SDK_BIN_PROFILE_FLAGS = --track-widget-creation
HOST_FLUTTER_SDK_BIN_SDK_PRODUCT = false
HOST_FLUTTER_SDK_BIN_SDK_ROOT = $(HOST_FLUTTER_SDK_BIN_SDK_ENGINE)/common/flutter_patched_sdk
HOST_FLUTTER_SDK_BIN_SDK_VM_PROFILE = true
else ifeq ($(BR2_ENABLE_RUNTIME_DEBUG),y)
HOST_FLUTTER_SDK_BIN_DEBUG_FLAGS = --enable-asserts
HOST_FLUTTER_SDK_BIN_SDK_PRODUCT = false
HOST_FLUTTER_SDK_BIN_SDK_ROOT = $(HOST_FLUTTER_SDK_BIN_SDK_ENGINE)/common/flutter_patched_sdk
HOST_FLUTTER_SDK_BIN_SDK_VM_PROFILE = false
else
HOST_FLUTTER_SDK_BIN_SDK_PRODUCT = true
HOST_FLUTTER_SDK_BIN_SDK_ROOT = $(HOST_FLUTTER_SDK_BIN_SDK_ENGINE)/common/flutter_patched_sdk_product
HOST_FLUTTER_SDK_BIN_SDK_VM_PROFILE = false
endif

# The Order matters.Taken from:
# https://github.com/meta-flutter/meta-flutter/blob/scarthgap/conf/include/common.inc
HOST_FLUTTER_SDK_BIN_DART_ARGS = \
	--verbose \
	--disable-analytics \
	--disable-dart-dev $(HOST_FLUTTER_SDK_BIN_SDK_ENGINE)/linux-x64/frontend_server_aot.dart.snapshot \
	--sdk-root $(HOST_FLUTTER_SDK_BIN_SDK_ROOT) \
	--target=flutter \
	--no-print-incremental-dependencies \
	-Ddart.vm.profile=$(HOST_FLUTTER_SDK_BIN_SDK_VM_PROFILE) \
	-Ddart.vm.product=$(HOST_FLUTTER_SDK_BIN_SDK_PRODUCT) \
	$(HOST_FLUTTER_SDK_BIN_DEBUG_FLAGS) \
	$(HOST_FLUTTER_SDK_BIN_PROFILE_FLAGS) \
	--aot \
	--tfa \
	--target-os linux \
	--packages .dart_tool/package_config.json \
	--output-dill .dart_tool/flutter_build/*/app.dill \
	--depfile .dart_tool/flutter_build/*/kernel_snapshot_program.d

# Helper wrapper to run flutter when building flutter applications.
HOST_FLUTTER_SDK_BIN_FLUTTER = \
	$(HOST_FLUTTER_SDK_BIN_ENV) \
	$(HOST_FLUTTER_SDK_BIN_SDK)/bin/flutter

# Helper wrapper to run dart when building flutter applications.
HOST_FLUTTER_SDK_BIN_DART_BIN = \
	$(HOST_FLUTTER_SDK_BIN_ENV) \
	$(HOST_FLUTTER_SDK_BIN_DART_SDK)/bin/dartaotruntime \
	$(HOST_FLUTTER_SDK_BIN_DART_ARGS)

$(eval $(host-generic-package))

# For target packages to locate said pub-cache
FLUTTER_SDK_BIN_PUB_CACHE = $(DL_DIR)/br-flutter-pub-cache
