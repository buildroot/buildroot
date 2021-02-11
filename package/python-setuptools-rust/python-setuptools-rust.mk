################################################################################
#
# python-setuptools-rust
#
################################################################################

PYTHON_SETUPTOOLS_RUST_VERSION = 0.11.6
PYTHON_SETUPTOOLS_RUST_SOURCE = setuptools-rust-$(PYTHON_SETUPTOOLS_RUST_VERSION).tar.gz
PYTHON_SETUPTOOLS_RUST_SITE = https://files.pythonhosted.org/packages/9d/87/7d1487395ab2e1d3c101d34b8e6ed346308f45349e5cdd3101963cc1c9cd
PYTHON_SETUPTOOLS_RUST_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_RUST_LICENSE = MIT
PYTHON_SETUPTOOLS_RUST_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_RUST_DEPENDENCIES = host-rustc host-python-setuptools-scm host-python-toml host-python-semantic-version
HOST_PYTHON_SETUPTOOLS_RUST_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
