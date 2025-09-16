################################################################################
#
# python-maturin
#
################################################################################

PYTHON_MATURIN_VERSION = 1.9.4
PYTHON_MATURIN_SOURCE_PYPI = maturin-$(PYTHON_MATURIN_VERSION).tar.gz
PYTHON_MATURIN_SITE_PYPI = https://files.pythonhosted.org/packages/13/7c/b11b870fc4fd84de2099906314ce45488ae17be32ff5493519a6cddc518a
PYTHON_MATURIN_SITE = $(PYTHON_MATURIN_SITE_PYPI)/$(PYTHON_MATURIN_SOURCE_PYPI)?buildroot-path=filename
PYTHON_MATURIN_SETUP_TYPE = setuptools-rust
PYTHON_MATURIN_LICENSE = Apache-2.0 or MIT
PYTHON_MATURIN_LICENSE_FILES = license-apache license-mit

$(eval $(host-python-package))
