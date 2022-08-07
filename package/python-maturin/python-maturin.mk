################################################################################
#
# python-maturin
#
################################################################################

PYTHON_MATURIN_VERSION = 1.1.0
PYTHON_MATURIN_SOURCE = maturin-$(PYTHON_MATURIN_VERSION).tar.gz
PYTHON_MATURIN_SITE = https://files.pythonhosted.org/packages/7b/78/2814bc0e46a96861aab337fd0404e7937acdb4ce187da239224ab4560d35
PYTHON_MATURIN_SETUP_TYPE = setuptools-rust
PYTHON_MATURIN_LICENSE = Apache-2.0 or MIT
PYTHON_MATURIN_LICENSE_FILES = license-apache license-mit
HOST_PYTHON_MATURIN_DEPENDENCIES = host-python-tomli

$(eval $(host-python-package))
