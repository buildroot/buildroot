################################################################################
#
# rust-bindgen
#
################################################################################

RUST_BINDGEN_VERSION = 0.65.1
RUST_BINDGEN_SITE = $(call github,rust-lang,rust-bindgen,v$(RUST_BINDGEN_VERSION))
RUST_BINDGEN_LICENSE = BSD-3-clause
RUST_BINDGEN_LICENSE_FILES = LICENSE

# The Cargo.toml at the root directory is a "virtual manifest".
# Since we only want to build and install bindgen use the Cargo.toml
# from the bindgen-cli subdirectory.
RUST_BINDGEN_SUBDIR = bindgen-cli

$(eval $(host-cargo-package))
