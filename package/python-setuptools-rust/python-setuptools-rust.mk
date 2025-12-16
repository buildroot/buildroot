################################################################################
#
# python-setuptools-rust
#
################################################################################

PYTHON_SETUPTOOLS_RUST_VERSION = 1.12.0
PYTHON_SETUPTOOLS_RUST_SOURCE = setuptools_rust-$(PYTHON_SETUPTOOLS_RUST_VERSION).tar.gz
PYTHON_SETUPTOOLS_RUST_SITE = https://files.pythonhosted.org/packages/bc/c4/8d3d282cee60d3ea0369fa15ce27387810040360adb4133e31990a7a2aba
PYTHON_SETUPTOOLS_RUST_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_RUST_LICENSE = MIT
PYTHON_SETUPTOOLS_RUST_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_RUST_DEPENDENCIES = \
	host-python-semantic-version \
	host-python-setuptools-scm \
	host-rustc

$(eval $(host-python-package))
