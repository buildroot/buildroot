################################################################################
#
# python-maturin
#
################################################################################

PYTHON_MATURIN_VERSION = 1.8.1
PYTHON_MATURIN_SOURCE_PYPI = maturin-$(PYTHON_MATURIN_VERSION).tar.gz
PYTHON_MATURIN_SITE_PYPI = https://files.pythonhosted.org/packages/9a/08/ccb0f917722a35ab0d758be9bb5edaf645c3a3d6170061f10d396ecd273f
PYTHON_MATURIN_SITE = $(PYTHON_MATURIN_SITE_PYPI)/$(PYTHON_MATURIN_SOURCE_PYPI)?buildroot-path=filename
PYTHON_MATURIN_SETUP_TYPE = setuptools-rust
PYTHON_MATURIN_LICENSE = Apache-2.0 or MIT
PYTHON_MATURIN_LICENSE_FILES = license-apache license-mit
HOST_PYTHON_MATURIN_DEPENDENCIES = host-python-tomli

$(eval $(host-python-package))
