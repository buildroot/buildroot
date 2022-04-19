################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.6.7
PYTHON_ORJSON_SITE = $(call github,ijl,orjson,$(PYTHON_ORJSON_VERSION))
PYTHON_ORJSON_LICENSE = Apache-2.0 or MIT
PYTHON_ORJSON_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_ORJSON_DEPENDENCIES = host-python-cffi
PYTHON_ORJSON_CARGO_ENV = \
	PYO3_CROSS_LIB_DIR="$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)"

# orjson uses "maturin" to generate distribution packages - rather than teach
# buildroot how to understand this, we reach in and install directly.
define PYTHON_ORJSON_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/target/$(RUSTC_TARGET_NAME)/release/liborjson.so \
		$(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/orjson.so
endef

$(eval $(cargo-package))
