################################################################################
#
# flutter-engine
#
################################################################################

# Flutter-engine has a release on the GitHub page. However, that release is
# only for Google. Its intended purpose is for the gclient tool provided by
# Google in their depot-tools package. To use the source code, we must use
# gclient to download the flutter-engine source code along with several other
# projects. Unfortunately, the Buildroot download system does not have the
# capability of using gclient, and considering this package is the only
# package that uses gclient, we side-step the entire download process and
# perform the following steps if a tarball does not exist already:
#
#  - Copy the pre-made gclient config file to a temporary scratch directory.
#  - Run gclient sync to generate a source directory with the proper
#    flutter-engine source code in the correct places.
#  - Create a source tarball.
#  - Copy the source tarball to the $(FLUTTER_ENGINE_DL_DIR) directory.
#
# There is no hash provided for the source tarball, as the gn binary
# (used for configuration) relies on the .git directories. As such, a
# reproducible tarball is not possible.
FLUTTER_ENGINE_VERSION = 3.29.2

# There is nothing for Buildroot to download. This is handled by gclient.
FLUTTER_ENGINE_SITE =
FLUTTER_ENGINE_SOURCE =
FLUTTER_ENGINE_LICENSE = BSD-3-Clause
FLUTTER_ENGINE_LICENSE_FILES = LICENSE
FLUTTER_ENGINE_TARBALL_PATH = $(FLUTTER_ENGINE_DL_DIR)/flutter-$(FLUTTER_ENGINE_VERSION).tar.gz
FLUTTER_ENGINE_INSTALL_STAGING = YES
FLUTTER_ENGINE_DOWNLOAD_DEPENDENCIES = host-depot-tools
FLUTTER_ENGINE_DEPENDENCIES = \
	host-flutter-sdk-bin \
	host-ninja \
	host-pkgconf \
	freetype \
	zlib

# Dispatch all architectures of flutter
# FLUTTER_ENGINE_TARGET_TRIPPLE must match the directory name found in
# engine/src/buildtools/linux-x64/clang/lib/clang/*/lib
ifeq ($(BR2_aarch64),y)
FLUTTER_ENGINE_TARGET_ARCH = arm64
FLUTTER_ENGINE_TARGET_TRIPPLE = aarch64-unknown-linux-gnu
else ifeq ($(BR2_arm)$(BR2_armeb),y)
FLUTTER_ENGINE_TARGET_ARCH = arm
FLUTTER_ENGINE_TARGET_TRIPPLE = armv7-unknown-linux-gnueabihf
else ifeq ($(BR2_x86_64),y)
FLUTTER_ENGINE_TARGET_ARCH = x64
FLUTTER_ENGINE_TARGET_TRIPPLE = x86_64-unknown-linux-gnu
endif

ifeq ($(FLUTTER_ENGINE_RUNTIME_MODE_PROFILE),y)
FLUTTER_ENGINE_RUNTIME_MODE=profile
else ifeq ($(BR2_ENABLE_RUNTIME_DEBUG),y)
FLUTTER_ENGINE_RUNTIME_MODE=debug
else
FLUTTER_ENGINE_RUNTIME_MODE=release
endif

FLUTTER_ENGINE_BUILD_DIR = \
	$(@D)/engine/src/out/linux_$(FLUTTER_ENGINE_RUNTIME_MODE)_$(FLUTTER_ENGINE_TARGET_ARCH)

FLUTTER_ENGINE_INSTALL_FILES = libflutter_engine.so

# Flutter engine includes a bundled patched clang that must be used for
# compiling or else there are linking errors.
FLUTTER_ENGINE_CLANG_PATH = $(@D)/engine/src/flutter/buildtools/linux-x64/clang

FLUTTER_ENGINE_CONF_OPTS = \
	--clang \
	--embedder-for-target \
	--linux-cpu $(FLUTTER_ENGINE_TARGET_ARCH) \
	--no-build-embedder-examples \
	--no-clang-static-analyzer \
	--no-enable-unittests \
	--no-goma \
	--no-prebuilt-dart-sdk \
	--no-stripped \
	--runtime-mode $(FLUTTER_ENGINE_RUNTIME_MODE) \
	--target-os linux \
	--target-sysroot $(STAGING_DIR) \
	--target-toolchain $(FLUTTER_ENGINE_CLANG_PATH) \
	--target-triple $(FLUTTER_ENGINE_TARGET_TRIPPLE)

ifeq ($(BR2_arm)$(BR2_armeb),y)
FLUTTER_ENGINE_CONF_OPTS += \
	--arm-float-abi $(call qstrip,$(BR2_GCC_TARGET_FLOAT_ABI))
endif

# We must specify a full path to ccache and a full path to the flutter-engine
# provided clang in order to use ccache, or else flutter-engine will error out
# attempting to find ccache in the target-toolchain provided path.
ifeq ($(BR2_CCACHE),y)
define FLUTTER_ENGINE_COMPILER_PATH_FIXUP
	$(SED) "s%cc =.*%cc = \"$(HOST_DIR)/bin/ccache $(FLUTTER_ENGINE_CLANG_PATH)/bin/clang\""%g \
		$(@D)/engine/src/build/toolchain/custom/BUILD.gn

	$(SED) "s%cxx =.*%cxx = \"$(HOST_DIR)/bin/ccache $(FLUTTER_ENGINE_CLANG_PATH)/bin/clang++\""%g \
		$(@D)/engine/src/build/toolchain/custom/BUILD.gn
endef
FLUTTER_ENGINE_PRE_CONFIGURE_HOOKS += FLUTTER_ENGINE_COMPILER_PATH_FIXUP
endif

ifeq ($(BR2_ENABLE_LTO),y)
FLUTTER_ENGINE_CONF_OPTS += --lto
else
FLUTTER_ENGINE_CONF_OPTS += --no-lto
endif

ifeq ($(BR2_OPTIMIZE_0),y)
FLUTTER_ENGINE_CONF_OPTS += --unoptimized
endif

# There is no --disable-fontconfig option.
ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
FLUTTER_ENGINE_DEPENDENCIES += fontconfig
FLUTTER_ENGINE_CONF_OPTS += --enable-fontconfig
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
FLUTTER_ENGINE_DEPENDENCIES += libgl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
FLUTTER_ENGINE_DEPENDENCIES += libgles
FLUTTER_ENGINE_CONF_OPTS += --enable-impeller-3d
endif

ifeq ($(BR2_PACKAGE_LIBGLFW),y)
FLUTTER_ENGINE_DEPENDENCIES += libglfw
FLUTTER_ENGINE_CONF_OPTS += --build-glfw-shell
else
FLUTTER_ENGINE_CONF_OPTS += --no-build-glfw-shell
endif

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
FLUTTER_ENGINE_DEPENDENCIES += libgtk3
FLUTTER_ENGINE_INSTALL_FILES += libflutter_linux_gtk.so
else
FLUTTER_ENGINE_CONF_OPTS += --disable-desktop-embeddings
endif

# There is no --disable-vulkan option
ifeq ($(BR2_PACKAGE_MESA3D_VULKAN_DRIVER),y)
FLUTTER_ENGINE_CONF_OPTS += --enable-vulkan
endif

ifeq ($(BR2_PACKAGE_XORG7)$(BR2_PACKAGE_LIBXCB),yy)
FLUTTER_ENGINE_DEPENDENCIES += libxcb
else
define FLUTTER_ENGINE_VULKAN_X11_SUPPORT_FIXUP
	$(SED) "s%vulkan_use_x11.*%vulkan_use_x11 = false%g" -i \
		$(@D)/engine/src/flutter/build_overrides/vulkan_headers.gni

	$(SED) "s%ozone_platform_x11.*%ozone_platform_x11 = false%g" \
		$(@D)/engine/src/build/config/BUILDCONFIG.gn
endef
FLUTTER_ENGINE_PRE_CONFIGURE_HOOKS += FLUTTER_ENGINE_VULKAN_X11_SUPPORT_FIXUP
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
FLUTTER_ENGINE_DEPENDENCIES += wayland
else
define FLUTTER_ENGINE_VULKAN_WAYLAND_SUPPORT_FIXUP
	$(SED) "s%vulkan_use_wayland.*%vulkan_use_wayland = false%g" \
		$(@D)/engine/src/flutter/build_overrides/vulkan_headers.gni

	$(SED) "s%ozone_platform_wayland.*%ozone_platform_wayland = false%g" \
		$(@D)/engine/src/build/config/BUILDCONFIG.gn
endef
FLUTTER_ENGINE_PRE_CONFIGURE_HOOKS += FLUTTER_ENGINE_VULKAN_WAYLAND_SUPPORT_FIXUP
endif

# Generate a tarball if one does not already exist.
define FLUTTER_ENGINE_GENERATE_TARBALL
	TAR="$(TAR)" \
	PATH=$(HOST_DIR)/share/depot_tools:$(BR_PATH) \
	PYTHONPATH=$(HOST_DIR)/lib/python$(PYTHON3_VERSION_MAJOR) \
	PUB_CACHE=$(FLUTTER_SDK_BIN_PUB_CACHE) \
	$(FLUTTER_ENGINE_PKGDIR)/gen-tarball \
		--dot-gclient $(TOPDIR)/$(FLUTTER_ENGINE_PKGDIR)/dot-gclient \
		--jobs $(PARALLEL_JOBS) \
		--scratch-dir $(@D)/dl-tmp \
		--tarball-dl-path $(FLUTTER_ENGINE_TARBALL_PATH) \
		--version $(FLUTTER_ENGINE_VERSION)
endef
FLUTTER_ENGINE_POST_DOWNLOAD_HOOKS += FLUTTER_ENGINE_GENERATE_TARBALL

define FLUTTER_ENGINE_EXTRACT_CMDS
	$(call suitable-extractor,$(FLUTTER_ENGINE_TARBALL_PATH)) $(FLUTTER_ENGINE_TARBALL_PATH) \
	| $(TAR) --strip-components=1 -C $(@D) $(TAR_OPTIONS) -
endef

# We must set the home directory to the sdk directory or else flutter will
# place .dart, and .flutter in ~/.
define FLUTTER_ENGINE_CONFIGURE_CMDS
	cd $(@D)/engine/src && \
		rm -rf $(FLUTTER_ENGINE_BUILD_DIR) && \
		PATH=$(HOST_DIR)/share/depot_tools:$(BR_PATH) \
		PUB_CACHE=$(FLUTTER_SDK_BIN_PUB_CACHE) \
		HOME=$(HOST_FLUTTER_SDK_BIN_SDK) \
		./flutter/tools/gn \
			$(FLUTTER_ENGINE_CONF_OPTS)
endef

define FLUTTER_ENGINE_BUILD_CMDS
	cd $(@D)/engine/src && \
		PATH=$(HOST_DIR)/share/depot_tools:$(BR_PATH) \
		PUB_CACHE=$(FLUTTER_SDK_BIN_PUB_CACHE) \
		HOME=$(HOST_FLUTTER_SDK_BIN_SDK) \
		$(HOST_DIR)/bin/ninja \
			-j $(PARALLEL_JOBS) \
			-C $(FLUTTER_ENGINE_BUILD_DIR)
endef

# Flutter-engine builds several host applications use for flutter development.
# One of those applications is gen_snapshot, which turns applications into
# usable .so files for the target architecture. Compiling a host version of
# flutter-engine would result in binaries producing host-architecture
# flutter applications .so files. As such, copy gen_snapshot to the host
# directory here and name it flutter_gen_snapshot for clarity.
FLUTTER_ENGINE_GEN_SNAPSHOT = $(HOST_DIR)/bin/flutter_gen_snapshot
define FLUTTER_ENGINE_INSTALL_GEN_SNAPSHOT
	$(INSTALL) -D -m 0755 $(FLUTTER_ENGINE_BUILD_DIR)/clang_x64/gen_snapshot \
		$(HOST_DIR)/bin/flutter_gen_snapshot
endef
FLUTTER_ENGINE_POST_INSTALL_STAGING_HOOKS += FLUTTER_ENGINE_INSTALL_GEN_SNAPSHOT

define FLUTTER_ENGINE_INSTALL_STAGING_CMDS
	$(foreach i,$(FLUTTER_ENGINE_INSTALL_FILES),
		$(INSTALL) -D -m 0755 $(FLUTTER_ENGINE_BUILD_DIR)/so.unstripped/$(i) \
			$(STAGING_DIR)/usr/lib/$(i); \
	)
	$(INSTALL) -D -m 0755 $(FLUTTER_ENGINE_BUILD_DIR)/flutter_embedder.h \
		$(STAGING_DIR)/usr/include/flutter_embedder.h

	$(INSTALL) -D -m 0755 $(FLUTTER_ENGINE_BUILD_DIR)/icudtl.dat \
		$(STAGING_DIR)/usr/share/flutter/$(FLUTTER_ENGINE_RUNTIME_MODE)/data/icudtl.dat
endef

define FLUTTER_ENGINE_INSTALL_TARGET_CMDS
	$(foreach i,$(FLUTTER_ENGINE_INSTALL_FILES),
		$(INSTALL) -D -m 0755 $(FLUTTER_ENGINE_BUILD_DIR)/so.unstripped/$(i) \
			$(TARGET_DIR)/usr/lib/$(i); \
	)
	$(INSTALL) -D -m 0755 $(FLUTTER_ENGINE_BUILD_DIR)/icudtl.dat \
		$(TARGET_DIR)/usr/share/flutter/$(FLUTTER_ENGINE_RUNTIME_MODE)/data/icudtl.dat
endef

$(eval $(generic-package))
