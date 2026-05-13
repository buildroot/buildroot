################################################################################
#
# python-pyopenssl
#
################################################################################

PYTHON_PYOPENSSL_VERSION = 25.0.0
PYTHON_PYOPENSSL_SOURCE = pyopenssl-$(PYTHON_PYOPENSSL_VERSION).tar.gz
PYTHON_PYOPENSSL_SITE = https://files.pythonhosted.org/packages/9f/26/e25b4a374b4639e0c235527bbe31c0524f26eda701d79456a7e1877f4cc5
PYTHON_PYOPENSSL_LICENSE = Apache-2.0
PYTHON_PYOPENSSL_LICENSE_FILES = LICENSE
PYTHON_PYOPENSSL_CPE_ID_VENDOR = pyopenssl
PYTHON_PYOPENSSL_CPE_ID_PRODUCT = pyopenssl
PYTHON_PYOPENSSL_SETUP_TYPE = setuptools

# 0001-CVE-2026-27448.patch
PYTHON_PYOPENSSL_IGNORE_CVES += CVE-2026-27448

# 0002-CVE-2026-27459.patch
PYTHON_PYOPENSSL_IGNORE_CVES += CVE-2026-27459

$(eval $(python-package))
