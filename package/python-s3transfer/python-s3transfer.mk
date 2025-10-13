################################################################################
#
# python-s3transfer
#
################################################################################

PYTHON_S3TRANSFER_VERSION = 0.14.0
PYTHON_S3TRANSFER_SOURCE = s3transfer-$(PYTHON_S3TRANSFER_VERSION).tar.gz
PYTHON_S3TRANSFER_SITE = https://files.pythonhosted.org/packages/62/74/8d69dcb7a9efe8baa2046891735e5dfe433ad558ae23d9e3c14c633d1d58
PYTHON_S3TRANSFER_SETUP_TYPE = setuptools
PYTHON_S3TRANSFER_LICENSE = Apache-2.0
PYTHON_S3TRANSFER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
