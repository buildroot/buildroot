################################################################################
#
# python-setuptools-rust
#
################################################################################

PYTHON_SETUPTOOLS_RUST_VERSION = 1.3.0
PYTHON_SETUPTOOLS_RUST_SOURCE = setuptools-rust-$(PYTHON_SETUPTOOLS_RUST_VERSION).tar.gz
PYTHON_SETUPTOOLS_RUST_SITE = https://files.pythonhosted.org/packages/a9/55/5db4a5b137af2afdc23a6e251d5ebb3b4e04c8deb68fbb5ffdacbd134c0c
PYTHON_SETUPTOOLS_RUST_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_RUST_LICENSE = MIT
PYTHON_SETUPTOOLS_RUST_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_RUST_DEPENDENCIES = host-rustc host-python-setuptools-scm host-python-toml host-python-semantic-version host-python-typing-extensions

$(eval $(host-python-package))
