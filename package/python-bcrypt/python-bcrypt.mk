################################################################################
#
# python-bcrypt
#
################################################################################

PYTHON_BCRYPT_VERSION = 4.0.1
PYTHON_BCRYPT_SOURCE = bcrypt-$(PYTHON_BCRYPT_VERSION).tar.gz
PYTHON_BCRYPT_SITE = https://files.pythonhosted.org/packages/8c/ae/3af7d006aacf513975fd1948a6b4d6f8b4a307f8a244e1a3d3774b297aad
PYTHON_BCRYPT_SETUP_TYPE = setuptools
PYTHON_BCRYPT_LICENSE = Apache-2.0
PYTHON_BCRYPT_LICENSE_FILES = LICENSE
PYTHON_BCRYPT_DEPENDENCIES = \
	host-python-setuptools-rust \
	host-rustc
PYTHON_BCRYPT_ENV = \
	$(PKG_CARGO_ENV) \
	PYO3_CROSS_LIB_DIR="$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)"
# We need to vendor the Cargo crates at download time
PYTHON_BCRYPT_DOWNLOAD_POST_PROCESS = cargo
PYTHON_BCRYPT_DOWNLOAD_DEPENDENCIES = host-rustc
PYTHON_BCRYPT_DL_ENV = \
	$(PKG_CARGO_ENV) \
	BR_CARGO_MANIFEST_PATH=src/_bcrypt/Cargo.toml

$(eval $(python-package))
