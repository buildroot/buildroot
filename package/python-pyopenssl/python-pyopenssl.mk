################################################################################
#
# python-pyopenssl
#
################################################################################

PYTHON_PYOPENSSL_VERSION = 23.3.0
PYTHON_PYOPENSSL_SOURCE = pyOpenSSL-$(PYTHON_PYOPENSSL_VERSION).tar.gz
PYTHON_PYOPENSSL_SITE = https://files.pythonhosted.org/packages/bf/a0/e667c3c43b65a188cc3041fa00c50655315b93be45182b2c94d185a2610e
PYTHON_PYOPENSSL_LICENSE = Apache-2.0
PYTHON_PYOPENSSL_LICENSE_FILES = LICENSE
PYTHON_PYOPENSSL_CPE_ID_VENDOR = pyopenssl
PYTHON_PYOPENSSL_CPE_ID_PRODUCT = pyopenssl
PYTHON_PYOPENSSL_SETUP_TYPE = setuptools

$(eval $(python-package))
