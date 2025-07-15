################################################################################
#
# python-setuptools-rust
#
################################################################################

PYTHON_SETUPTOOLS_RUST_VERSION = 1.11.1
PYTHON_SETUPTOOLS_RUST_SOURCE = setuptools_rust-$(PYTHON_SETUPTOOLS_RUST_VERSION).tar.gz
PYTHON_SETUPTOOLS_RUST_SITE = https://files.pythonhosted.org/packages/e0/92/bf8589b1a2b6107cf9ec8daa9954c0b7620643fe1f37d31d75e572d995f5
PYTHON_SETUPTOOLS_RUST_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_RUST_LICENSE = MIT
PYTHON_SETUPTOOLS_RUST_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_RUST_DEPENDENCIES = \
	host-python-semantic-version \
	host-python-setuptools-scm \
	host-rustc

$(eval $(host-python-package))
