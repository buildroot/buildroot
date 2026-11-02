################################################################################
#
# python-cbor2
#
################################################################################

PYTHON_CBOR2_VERSION = 6.2.0.post2
PYTHON_CBOR2_SOURCE_PYPI = cbor2-$(PYTHON_CBOR2_VERSION).tar.gz
PYTHON_CBOR2_SITE_PYPI = https://files.pythonhosted.org/packages/cd/eb/e2ef5f241f15131babf4854032953b97c88b2c2700d7712a0ba8f57cbe81
PYTHON_CBOR2_SITE = $(PYTHON_CBOR2_SITE_PYPI)/$(PYTHON_CBOR2_SOURCE_PYPI)?buildroot-path=filename
PYTHON_CBOR2_SETUP_TYPE = setuptools-rust
PYTHON_CBOR2_CARGO_MANIFEST_PATH = rust/Cargo.toml
PYTHON_CBOR2_LICENSE = MIT
PYTHON_CBOR2_LICENSE_FILES = LICENSE.txt
PYTHON_CBOR2_CPE_ID_VENDOR = agronholm
PYTHON_CBOR2_CPE_ID_PRODUCT = cbor2
PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
