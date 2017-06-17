################################################################################
#
# rust
#
################################################################################

RUST_VERSION = 1.18.0
RUST_SOURCE = rustc-$(RUST_VERSION)-src.tar.gz
RUST_SITE = https://static.rust-lang.org/dist
RUST_LICENSE = Apache-2.0 or MIT
RUST_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

HOST_RUST_PROVIDES = host-rustc

HOST_RUST_DEPENDENCIES = \
	toolchain \
	host-rust-bootstrap \
	host-cargo-bootstrap \
	host-python \
	host-cmake

ifeq ($(BR2_PACKAGE_JEMALLOC),y)
HOST_RUST_DEPENDENCIES += jemalloc
HOST_RUST_JEMALLOC_ENABLED = true
HOST_RUST_JEMALLOC_CONF = 'jemalloc = "$(STAGING_DIR)/usr/lib/libjemalloc_pic.a"'
else
HOST_RUST_JEMALLOC_ENABLED = false
endif

HOST_RUST_BUILD_OPTS = $(if $(VERBOSE),--verbose)

define HOST_RUST_CONFIGURE_CMDS
	(cd $(@D); \
		echo '[build]' > config.toml; \
		echo 'target = ["$(RUST_TARGET_NAME)"]' >> config.toml; \
		echo 'cargo = "$(HOST_CARGO_BOOTSTRAP_DIR)/cargo/bin/cargo"' >> config.toml; \
		echo 'rustc = "$(HOST_RUST_BOOTSTRAP_DIR)/rustc/bin/rustc"' >> config.toml; \
		echo 'python = "$(HOST_DIR)/usr/bin/python2"' >> config.toml; \
		echo 'submodules = false' >> config.toml; \
		echo 'vendor = true' >> config.toml; \
		echo 'compiler-docs = false' >> config.toml; \
		echo 'docs = false' >> config.toml; \
		echo '[install]' >> config.toml; \
		echo 'prefix = "$(HOST_DIR)/usr"' >> config.toml; \
		echo '[rust]' >> config.toml; \
		echo 'use-jemalloc = $(HOST_RUST_JEMALLOC_ENABLED)' >> config.toml; \
		echo '[target.$(RUST_TARGET_NAME)]' >> config.toml; \
		echo 'cc = "$(TARGET_CROSS)gcc"' >> config.toml; \
		echo 'cxx = "$(TARGET_CROSS)g++"' >> config.toml; \
		echo $(HOST_RUST_JEMALLOC_CONF) >> config.toml; \
	)
endef

define HOST_RUST_BUILD_CMDS
	(cd $(@D); $(HOST_MAKE_ENV) $(HOST_RUST_MAKE_ENV) python2 x.py \
		build $(HOST_RUST_BUILD_OPTS))
endef

define HOST_RUST_INSTALL_LIBSTD_TARGET
	(cd $(@D)/build/tmp/dist/rust-std-$(RUST_VERSION)-dev-$(RUST_TARGET_NAME); \
		./install.sh \
			--prefix=$(HOST_DIR)/usr \
			--docdir=$(HOST_DIR)/usr/share/doc/rust \
			--libdir=$(HOST_DIR)/usr/lib \
			--mandir=$(HOST_DIR)/usr/share/man \
			--disable-ldconfig)
endef

define HOST_RUST_INSTALL_CMDS
	(cd $(@D); $(HOST_MAKE_ENV) $(HOST_RUST_MAKE_ENV) python2 x.py \
		dist $(HOST_RUST_BUILD_OPTS))
	(cd $(@D); $(HOST_MAKE_ENV) $(HOST_RUST_MAKE_ENV) python2 x.py \
		dist --install $(HOST_RUST_BUILD_OPTS))
	$(HOST_RUST_INSTALL_LIBSTD_TARGET)
endef

$(eval $(host-generic-package))
