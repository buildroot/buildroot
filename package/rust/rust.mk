################################################################################
#
# rust
#
################################################################################

# When updating this version, check whether support/download/cargo-post-process
# still generates the same archives.
RUST_VERSION = 1.86.0
RUST_SOURCE = rustc-$(RUST_VERSION)-src.tar.xz
RUST_SITE = https://static.rust-lang.org/dist
RUST_LICENSE = Apache-2.0 or MIT
RUST_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

HOST_RUST_PROVIDES = host-rustc

HOST_RUST_DEPENDENCIES = \
	toolchain \
	host-pkgconf \
	host-python3 \
	host-rust-bin \
	host-openssl \
	host-zlib \
	$(BR2_CMAKE_HOST_DEPENDENCY)

HOST_RUST_VERBOSITY = $(if $(VERBOSE),2,0)

define HOST_RUST_CONFIGURE_CMDS
	( \
		echo '[build]'; \
		echo 'target = ["$(RUSTC_TARGET_NAME)"]'; \
		echo 'cargo = "$(HOST_RUST_BIN_DIR)/cargo/bin/cargo"'; \
		echo 'rustc = "$(HOST_RUST_BIN_DIR)/rustc/bin/rustc"'; \
		echo 'python = "$(HOST_DIR)/bin/python$(PYTHON3_VERSION_MAJOR)"'; \
		echo 'submodules = false'; \
		echo 'vendor = true'; \
		echo 'extended = true'; \
		echo 'tools = ["cargo"]'; \
		echo 'compiler-docs = false'; \
		echo 'docs = false'; \
		echo 'verbose = $(HOST_RUST_VERBOSITY)'; \
		echo '[install]'; \
		echo 'prefix = "$(HOST_DIR)"'; \
		echo 'sysconfdir = "$(HOST_DIR)/etc"'; \
		echo '[rust]'; \
		echo 'channel = "stable"'; \
		echo 'musl-root = "$(STAGING_DIR)"' ; \
		echo '[target.$(RUSTC_TARGET_NAME)]'; \
		echo 'cc = "$(TARGET_CROSS)gcc"'; \
		echo '[llvm]'; \
		echo 'download-ci-llvm = false'; \
		echo 'ninja = false'; \
		echo 'ldflags = "$(HOST_LDFLAGS)"'; \
	) > $(@D)/config.toml
endef

define HOST_RUST_BUILD_CMDS
	cd $(@D); $(HOST_MAKE_ENV) $(HOST_PKG_CARGO_ENV) \
		$(HOST_DIR)/bin/python$(PYTHON3_VERSION_MAJOR) x.py build
endef

HOST_RUST_INSTALL_OPTS = \
	--prefix=$(HOST_DIR) \
	--disable-ldconfig

define HOST_RUST_INSTALL_RUSTC
	cd $(@D)/build/tmp/tarball/rust/$(RUSTC_HOST_NAME)/rust-$(RUST_VERSION)-$(RUSTC_HOST_NAME); \
		./install.sh $(HOST_RUST_INSTALL_OPTS) --components=rustc,cargo,rust-std-$(RUSTC_HOST_NAME)
endef

ifeq ($(BR2_PACKAGE_HOST_RUSTC_TARGET_ARCH_SUPPORTS),y)
define HOST_RUST_INSTALL_LIBSTD_TARGET
	cd $(@D)/build/tmp/tarball/rust-std/$(RUSTC_TARGET_NAME)/rust-std-$(RUST_VERSION)-$(RUSTC_TARGET_NAME); \
		./install.sh $(HOST_RUST_INSTALL_OPTS)
endef
endif

define HOST_RUST_INSTALL_CMDS
	cd $(@D); $(HOST_MAKE_ENV) $(HOST_DIR)/bin/python$(PYTHON3_VERSION_MAJOR) x.py dist
	$(HOST_RUST_INSTALL_RUSTC)
	$(HOST_RUST_INSTALL_LIBSTD_TARGET)
endef

$(eval $(host-generic-package))
