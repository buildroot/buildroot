################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.8.3
PYTHON_ORJSON_SOURCE = orjson-$(PYTHON_ORJSON_VERSION).tar.gz
PYTHON_ORJSON_SITE = https://files.pythonhosted.org/packages/1c/b9/a0b4fb195ded02820e0a933ffe28b782b7e5ef7a4f8c1e1c742d619548e4
PYTHON_ORJSON_SETUP_TYPE = pep517
PYTHON_ORJSON_LICENSE = Apache-2.0 or MIT
PYTHON_ORJSON_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_ORJSON_DEPENDENCIES = host-python-cffi host-python-maturin
PYTHON_ORJSON_ENV = \
	$(PKG_CARGO_ENV) \
	PYO3_CROSS_LIB_DIR="$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)"
# We need to vendor the Cargo crates at download time
PYTHON_ORJSON_DOWNLOAD_POST_PROCESS = cargo
PYTHON_ORJSON_DOWNLOAD_DEPENDENCIES = host-rustc
PYTHON_ORJSON_DL_ENV = $(PKG_CARGO_ENV)

$(eval $(python-package))
