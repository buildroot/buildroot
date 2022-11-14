################################################################################
#
# python-pyopenssl
#
################################################################################

PYTHON_PYOPENSSL_VERSION = 22.0.0
PYTHON_PYOPENSSL_SOURCE = pyOpenSSL-$(PYTHON_PYOPENSSL_VERSION).tar.gz
PYTHON_PYOPENSSL_SITE = https://files.pythonhosted.org/packages/35/d3/d6a9610f19d943e198df502ae660c6b5acf84cc3bc421a2aa3c0fb6b21d1
PYTHON_PYOPENSSL_LICENSE = Apache-2.0
PYTHON_PYOPENSSL_LICENSE_FILES = LICENSE
PYTHON_PYOPENSSL_CPE_ID_VENDOR = pyopenssl
PYTHON_PYOPENSSL_CPE_ID_PRODUCT = pyopenssl
PYTHON_PYOPENSSL_SETUP_TYPE = setuptools

$(eval $(python-package))
