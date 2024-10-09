################################################################################
#
# python-setuptools-rust
#
################################################################################

PYTHON_SETUPTOOLS_RUST_VERSION = 1.10.2
PYTHON_SETUPTOOLS_RUST_SOURCE = setuptools_rust-$(PYTHON_SETUPTOOLS_RUST_VERSION).tar.gz
PYTHON_SETUPTOOLS_RUST_SITE = https://files.pythonhosted.org/packages/d3/6b/99a1588d826ceb108694ba00f78bc6afda10ed5d72d550ae8f256af1f7b4
PYTHON_SETUPTOOLS_RUST_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_RUST_LICENSE = MIT
PYTHON_SETUPTOOLS_RUST_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_RUST_DEPENDENCIES = \
	host-python-semantic-version \
	host-python-setuptools-scm \
	host-rustc

$(eval $(host-python-package))
