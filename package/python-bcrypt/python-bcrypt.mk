################################################################################
#
# python-bcrypt
#
################################################################################

PYTHON_BCRYPT_VERSION = 5.0.0
PYTHON_BCRYPT_SOURCE_PYPI = bcrypt-$(PYTHON_BCRYPT_VERSION).tar.gz
PYTHON_BCRYPT_SITE_PYPI = https://files.pythonhosted.org/packages/d4/36/3329e2518d70ad8e2e5817d5a4cac6bba05a47767ec416c7d020a965f408
PYTHON_BCRYPT_SITE = $(PYTHON_BCRYPT_SITE_PYPI)/$(PYTHON_BCRYPT_SOURCE_PYPI)?buildroot-path=filename
PYTHON_BCRYPT_SETUP_TYPE = setuptools-rust
PYTHON_BCRYPT_LICENSE = Apache-2.0
PYTHON_BCRYPT_LICENSE_FILES = LICENSE
PYTHON_BCRYPT_CARGO_MANIFEST_PATH = src/_bcrypt/Cargo.toml

$(eval $(python-package))
