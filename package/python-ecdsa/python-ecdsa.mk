################################################################################
#
# python-ecdsa
#
################################################################################

PYTHON_ECDSA_VERSION = 0.18.0
PYTHON_ECDSA_SOURCE = ecdsa-$(PYTHON_ECDSA_VERSION).tar.gz
PYTHON_ECDSA_SITE = https://files.pythonhosted.org/packages/ff/7b/ba6547a76c468a0d22de93e89ae60d9561ec911f59532907e72b0d8bc0f1
PYTHON_ECDSA_SETUP_TYPE = setuptools
PYTHON_ECDSA_LICENSE = MIT
PYTHON_ECDSA_LICENSE_FILES = LICENSE
PYTHON_ECDSA_CPE_ID_VENDOR = python-ecdsa_project

$(eval $(python-package))
