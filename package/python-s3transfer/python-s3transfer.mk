################################################################################
#
# python-s3transfer
#
################################################################################

PYTHON_S3TRANSFER_VERSION = 0.19.2
PYTHON_S3TRANSFER_SOURCE = s3transfer-$(PYTHON_S3TRANSFER_VERSION).tar.gz
PYTHON_S3TRANSFER_SITE = https://files.pythonhosted.org/packages/76/43/35e4d8aa320bffe8287fe8f65f578fa2d2db0a64212f0e710dce58267854
PYTHON_S3TRANSFER_SETUP_TYPE = setuptools
PYTHON_S3TRANSFER_LICENSE = Apache-2.0
PYTHON_S3TRANSFER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
