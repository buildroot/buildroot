################################################################################
#
# cargo
#
################################################################################

CARGO_VERSION = 0.19.0
CARGO_SITE = $(call github,rust-lang,cargo,$(CARGO_VERSION))
CARGO_LICENSE = Apache-2.0 or MIT
CARGO_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

CARGO_DEPS_SITE = http://pkgs.fedoraproject.org/repo/pkgs/cargo/$(CARGO_DEPS_SOURCE)/sha512/$(CARGO_DEPS_SHA512)
CARGO_DEPS_SHA512 = 40d4fc9c4f2d3b7dd14fd3e93317c8f144e5ca7fcab7dab345a2920817d7e0ccb6a1b47405d8ffdc1b49acd54af06fd05d3023f34b7280f186814edc2e6af8e6
CARGO_DEPS_SOURCE = cargo-$(CARGO_VERSION)-vendor.tar.xz

CARGO_INSTALLER_VERSION = 4f994850808a572e2cc8d43f968893c8e942e9bf
CARGO_INSTALLER_SITE = https://github.com/rust-lang/rust-installer/archive/$(CARGO_INSTALLER_VERSION)
CARGO_INSTALLER_SOURCE = rust-installer-$(CARGO_INSTALLER_VERSION).tar.gz

HOST_CARGO_EXTRA_DOWNLOADS = \
	$(CARGO_DEPS_SITE)/$(CARGO_DEPS_SOURCE) \
	$(CARGO_INSTALLER_SITE)/$(CARGO_INSTALLER_SOURCE)

HOST_CARGO_DEPENDENCIES = \
	host-cmake \
	host-pkgconf \
	host-openssl \
	host-libhttpparser \
	host-libssh2 \
	host-libcurl \
	host-rustc \
	host-cargo-bootstrap

HOST_CARGO_SNAP_BIN = $(HOST_CARGO_BOOTSTRAP_DIR)/cargo/bin/cargo
HOST_CARGO_HOME = $(HOST_DIR)/usr/share/cargo
HOST_CARGO_SNAP_ENV = \
	$(HOST_MAKE_ENV) \
	CARGO_HOME=$(HOST_CARGO_HOME)

define HOST_CARGO_EXTRACT_DEPS
	@mkdir -p $(@D)/vendor
	$(call suitable-extractor,$(CARGO_DEPS_SOURCE)) \
		$(DL_DIR)/$(CARGO_DEPS_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/vendor $(TAR_OPTIONS) -
endef

HOST_CARGO_POST_EXTRACT_HOOKS += HOST_CARGO_EXTRACT_DEPS

define HOST_CARGO_EXTRACT_INSTALLER
	@mkdir -p $(@D)/src/rust-installer
	$(call suitable-extractor,$(CARGO_INSTALLER_SOURCE)) \
		$(DL_DIR)/$(CARGO_INSTALLER_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/src/rust-installer $(TAR_OPTIONS) -
endef

HOST_CARGO_POST_EXTRACT_HOOKS += HOST_CARGO_EXTRACT_INSTALLER

define HOST_CARGO_SETUP_DEPS
	mkdir -p $(@D)/.cargo
	(cd $(@D)/.cargo; \
		echo "[source.crates-io]" > config; \
		echo "registry = 'https://github.com/rust-lang/crates.io-index'" >> config; \
		echo "replace-with = 'vendored-sources'" >> config; \
		echo >> config; \
		echo "[source.vendored-sources]" >> config; \
		echo "directory = '$(@D)/vendor'" >> config; \
	)
endef

HOST_CARGO_PRE_CONFIGURE_HOOKS += HOST_CARGO_SETUP_DEPS

HOST_CARGO_MAKE_OPTS = $(if $(VERBOSE),VERBOSE=1)

HOST_CARGO_ENV = \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_LIBDIR="$(HOST_DIR)/usr/lib/pkgconfig:$(HOST_DIR)/usr/share/pkgconfig" \
	CARGO_HOME=$(HOST_DIR)/usr/share/cargo

define HOST_CARGO_CONFIGURE_CMDS
	(cd $(@D); $(HOST_CARGO_ENV)                    \
		$(HOST_CONFIGURE_OPTS)                  \
		./configure                             \
		--prefix="$(HOST_DIR)/usr"              \
		--cargo="$(HOST_CARGO_SNAP_BIN)"        \
		--local-rust-root="$(HOST_DIR)/usr"     \
		--sysconfdir="$(HOST_DIR)/etc"          \
		--localstatedir="$(HOST_DIR)/var/lib"   \
		--datadir="$(HOST_DIR)/usr/share"       \
		--infodir="$(HOST_DIR)/usr/share/info")
endef

define HOST_CARGO_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CARGO_ENV) $(MAKE) \
		$(HOST_CARGO_MAKE_OPTS) -C $(@D)
endef

define HOST_CARGO_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_CARGO_ENV) $(MAKE) \
		$(HOST_CARGO_MAKE_OPTS) -C $(@D) install
endef

define HOST_CARGO_INSTALL_CONF_FILE
	$(INSTALL) -D package/cargo/config.in \
		$(HOST_DIR)/usr/share/cargo/config
	$(SED) 's/@RUST_TARGET_NAME@/$(RUST_TARGET_NAME)/' \
		$(HOST_DIR)/usr/share/cargo/config
	$(SED) 's/@CROSS_PREFIX@/$(notdir $(TARGET_CROSS))/' \
		$(HOST_DIR)/usr/share/cargo/config
endef

HOST_CARGO_POST_INSTALL_HOOKS += HOST_CARGO_INSTALL_CONF_FILE

# No *RPATH tag is set in the Cargo binary, so provide a wrapper to find the
# shared libraries
define HOST_CARGO_INSTALL_WRAPPER
	mv $(HOST_DIR)/usr/bin/cargo $(HOST_DIR)/usr/bin/cargo.real
	$(INSTALL) -m 0755 package/cargo/cargo.in \
		$(HOST_DIR)/usr/bin/cargo
	$(SED) 's;@HOST_DIR@;$(HOST_DIR);g' $(HOST_DIR)/usr/bin/cargo
endef

HOST_CARGO_POST_INSTALL_HOOKS += HOST_CARGO_INSTALL_WRAPPER

$(eval $(host-generic-package))
