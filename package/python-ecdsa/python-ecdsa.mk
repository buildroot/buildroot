################################################################################
#
# python-ecdsa
#
################################################################################

PYTHON_ECDSA_VERSION = 0.17.0
PYTHON_ECDSA_SOURCE = ecdsa-$(PYTHON_ECDSA_VERSION).tar.gz
PYTHON_ECDSA_SITE = https://files.pythonhosted.org/packages/bf/3d/3d909532ad541651390bf1321e097404cbd39d1d89c2046f42a460220fb3
PYTHON_ECDSA_SETUP_TYPE = setuptools
PYTHON_ECDSA_LICENSE = MIT
PYTHON_ECDSA_LICENSE_FILES = LICENSE
PYTHON_ECDSA_CPE_ID_VENDOR = python-ecdsa_project

$(eval $(python-package))
