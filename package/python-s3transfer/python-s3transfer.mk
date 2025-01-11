################################################################################
#
# python-s3transfer
#
################################################################################

PYTHON_S3TRANSFER_VERSION = 0.10.4
PYTHON_S3TRANSFER_SOURCE = s3transfer-$(PYTHON_S3TRANSFER_VERSION).tar.gz
PYTHON_S3TRANSFER_SITE = https://files.pythonhosted.org/packages/c0/0a/1cdbabf9edd0ea7747efdf6c9ab4e7061b085aa7f9bfc36bb1601563b069
PYTHON_S3TRANSFER_SETUP_TYPE = setuptools
PYTHON_S3TRANSFER_LICENSE = Apache-2.0
PYTHON_S3TRANSFER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
