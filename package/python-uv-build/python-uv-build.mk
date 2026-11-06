################################################################################
#
# python-uv-build
#
################################################################################

PYTHON_UV_BUILD_VERSION = 0.13.7
PYTHON_UV_BUILD_SOURCE_PYPI = uv_build-$(PYTHON_UV_BUILD_VERSION).tar.gz
PYTHON_UV_BUILD_SITE_PYPI = https://files.pythonhosted.org/packages/73/a5/916905235227c4f074ec0b125a3f2a5ba1839892e64c9be20200c48bdb5c
PYTHON_UV_BUILD_SITE = $(PYTHON_UV_BUILD_SITE_PYPI)/$(PYTHON_UV_BUILD_SOURCE_PYPI)?buildroot-path=filename
PYTHON_UV_BUILD_SETUP_TYPE = maturin
PYTHON_UV_BUILD_LICENSE = MIT or Apache-2.0
PYTHON_UV_BUILD_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_UV_BUILD_CARGO_MANIFEST_PATH = crates/uv-build/Cargo.toml

$(eval $(host-python-package))
