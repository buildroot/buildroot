################################################################################
#
# rust-bin
#
################################################################################

RUST_BIN_VERSION = 1.18.0
RUST_BIN_SITE = https://static.rust-lang.org/dist
RUST_BIN_LICENSE = Apache-2.0 or MIT
RUST_BIN_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

HOST_RUST_BIN_PROVIDES = host-rustc

HOST_RUST_BIN_SOURCE = rustc-$(RUST_BIN_VERSION)-$(RUST_HOST_NAME).tar.gz
HOST_RUST_BIN_LIBSTD_SOURCES = \
	rust-std-$(RUST_BIN_VERSION)-$(RUST_HOST_NAME).tar.gz \
	rust-std-$(RUST_BIN_VERSION)-$(RUST_TARGET_NAME).tar.gz

HOST_RUST_BIN_EXTRA_DOWNLOADS = $(HOST_RUST_BIN_LIBSTD_SOURCES)

define HOST_RUST_BIN_LIBSTD_EXTRACT
	mkdir -p $(@D)/std
	for file in $(addprefix $(DL_DIR)/,$(HOST_RUST_BIN_LIBSTD_SOURCES)); do \
		$(TAR) -C $(@D)/std -xzf $${file}; \
	done
endef

HOST_RUST_BIN_POST_EXTRACT_HOOKS += HOST_RUST_BIN_LIBSTD_EXTRACT

define HOST_RUST_BIN_INSTALL_CMDS
	for exe in $$(find $(@D) -name install.sh -executable); do \
		$${exe} \
			--prefix=$(HOST_DIR)/usr \
			--docdir=$(HOST_DIR)/usr/share/doc/rust \
			--libdir=$(HOST_DIR)/usr/lib \
			--mandir=$(HOST_DIR)/usr/share/man \
			--disable-ldconfig; \
	done
endef

$(eval $(host-generic-package))
