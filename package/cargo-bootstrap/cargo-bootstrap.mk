################################################################################
#
# cargo-bootstrap
#
################################################################################

CARGO_BOOTSTRAP_VERSION = 6e0c18cccc8b0c06fba8a8d76486f81a792fb420
CARGO_BOOTSTRAP_SITE = https://s3.amazonaws.com/rust-lang-ci/cargo-builds/$(CARGO_BOOTSTRAP_VERSION)
CARGO_BOOTSTRAP_SOURCE = cargo-nightly-$(RUST_HOST_NAME).tar.gz
CARGO_BOOTSTRAP_LICENSE = Apache-2.0 or MIT
CARGO_BOOTSTRAP_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
CARGO_BOOTSTRAP_STRIP_COMPONENTS = 1

$(eval $(host-generic-package))
