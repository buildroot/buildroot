################################################################################
#
# python-ecdsa
#
################################################################################

PYTHON_ECDSA_VERSION = 0.16.1
PYTHON_ECDSA_SOURCE = ecdsa-$(PYTHON_ECDSA_VERSION).tar.gz
PYTHON_ECDSA_SITE = https://files.pythonhosted.org/packages/1d/d4/0684a83b3c16a9d1446ace27a506cef1db9b23984ac7ed6aaf764fdd56e8
PYTHON_ECDSA_SETUP_TYPE = setuptools
PYTHON_ECDSA_LICENSE = MIT
PYTHON_ECDSA_LICENSE_FILES = LICENSE
PYTHON_ECDSA_CPE_ID_VENDOR = python-ecdsa_project

$(eval $(python-package))
