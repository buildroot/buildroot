################################################################################
#
# python-cryptography
#
################################################################################

PYTHON_CRYPTOGRAPHY_VERSION = 44.0.1
PYTHON_CRYPTOGRAPHY_SOURCE_PYPI = cryptography-$(PYTHON_CRYPTOGRAPHY_VERSION).tar.gz
PYTHON_CRYPTOGRAPHY_SITE_PYPI = https://files.pythonhosted.org/packages/c7/67/545c79fe50f7af51dbad56d16b23fe33f63ee6a5d956b3cb68ea110cbe64
PYTHON_CRYPTOGRAPHY_SITE = $(PYTHON_CRYPTOGRAPHY_SITE_PYPI)/$(PYTHON_CRYPTOGRAPHY_SOURCE_PYPI)?buildroot-path=filename
PYTHON_CRYPTOGRAPHY_SETUP_TYPE = maturin
PYTHON_CRYPTOGRAPHY_LICENSE = Apache-2.0 or BSD-3-Clause
PYTHON_CRYPTOGRAPHY_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD
PYTHON_CRYPTOGRAPHY_CPE_ID_VENDOR = cryptography.io
PYTHON_CRYPTOGRAPHY_CPE_ID_PRODUCT = cryptography
PYTHON_CRYPTOGRAPHY_CARGO_MANIFEST_PATH = src/rust/Cargo.toml
PYTHON_CRYPTOGRAPHY_DEPENDENCIES = \
	host-python-cffi \
	host-python-setuptools \
	openssl
HOST_PYTHON_CRYPTOGRAPHY_DEPENDENCIES = \
	host-python-cffi \
	host-python-setuptools \
	host-openssl
PYTHON_CRYPTOGRAPHY_BUILD_OPTS = --skip-dependency-check
HOST_PYTHON_CRYPTOGRAPHY_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
$(eval $(host-python-package))
