################################################################################
#
# python-cryptography
#
################################################################################

PYTHON_CRYPTOGRAPHY_VERSION = 36.0.1
PYTHON_CRYPTOGRAPHY_SOURCE = cryptography-$(PYTHON_CRYPTOGRAPHY_VERSION).tar.gz
PYTHON_CRYPTOGRAPHY_SITE = https://files.pythonhosted.org/packages/f9/4b/1cf8e281f7ae4046a59e5e39dd7471d46db9f61bb564fddbff9084c4334f
PYTHON_CRYPTOGRAPHY_SETUP_TYPE = setuptools
PYTHON_CRYPTOGRAPHY_LICENSE = Apache-2.0 or BSD-3-Clause
PYTHON_CRYPTOGRAPHY_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD
PYTHON_CRYPTOGRAPHY_CPE_ID_VENDOR = cryptography_project
PYTHON_CRYPTOGRAPHY_CPE_ID_PRODUCT = cryptography
PYTHON_CRYPTOGRAPHY_DEPENDENCIES = host-python-setuptools-rust host-python-cffi host-rustc
PYTHON_CRYPTOGRAPHY_ENV = \
	$(PKG_CARGO_ENV) \
	PYO3_CROSS_LIB_DIR="$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)"
# We need to vendor the Cargo crates at download time
PYTHON_CRYPTOGRAPHY_DOWNLOAD_POST_PROCESS = cargo
PYTHON_CRYPTOGRAPHY_DOWNLOAD_DEPENDENCIES = host-rustc
PYTHON_CRYPTOGRAPHY_DL_ENV = \
	BR_CARGO_MANIFEST_PATH=src/rust/Cargo.toml

$(eval $(python-package))
