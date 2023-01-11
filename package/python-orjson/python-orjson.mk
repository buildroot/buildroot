################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.8.4
PYTHON_ORJSON_SOURCE = orjson-$(PYTHON_ORJSON_VERSION).tar.gz
PYTHON_ORJSON_SITE = https://files.pythonhosted.org/packages/8f/2d/ae31eddf7e097eec5e25c7da954ef6e944f4dbf79153676f94cea3dc5116
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
