################################################################################
#
# python-uv-build
#
################################################################################

PYTHON_UV_BUILD_VERSION = 0.12.23
PYTHON_UV_BUILD_SOURCE_PYPI = uv_build-$(PYTHON_UV_BUILD_VERSION).tar.gz
PYTHON_UV_BUILD_SITE_PYPI = https://files.pythonhosted.org/packages/b4/65/672d5c1e7fff2a602b51758cd96c379ea80c0c20d9d10aae5139bfde9877
PYTHON_UV_BUILD_SITE = $(PYTHON_UV_BUILD_SITE_PYPI)/$(PYTHON_UV_BUILD_SOURCE_PYPI)?buildroot-path=filename
PYTHON_UV_BUILD_SETUP_TYPE = maturin
PYTHON_UV_BUILD_LICENSE = MIT or Apache-2.0
PYTHON_UV_BUILD_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_UV_BUILD_CARGO_MANIFEST_PATH = crates/uv-build/Cargo.toml

$(eval $(host-python-package))
