################################################################################
#
# python-maturin
#
################################################################################

PYTHON_MATURIN_VERSION = 1.3.1
PYTHON_MATURIN_SOURCE = maturin-$(PYTHON_MATURIN_VERSION).tar.gz
PYTHON_MATURIN_SITE = https://files.pythonhosted.org/packages/d6/a3/42ff26b2b3011ada67c73db32a9ccf9fa18d459cbef8ed6eefc3b283ee60
PYTHON_MATURIN_SETUP_TYPE = setuptools-rust
PYTHON_MATURIN_LICENSE = Apache-2.0 or MIT
PYTHON_MATURIN_LICENSE_FILES = license-apache license-mit
HOST_PYTHON_MATURIN_DEPENDENCIES = host-python-tomli

$(eval $(host-python-package))
