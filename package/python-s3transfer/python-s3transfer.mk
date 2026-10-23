################################################################################
#
# python-s3transfer
#
################################################################################

PYTHON_S3TRANSFER_VERSION = 0.19.3
PYTHON_S3TRANSFER_SOURCE = s3transfer-$(PYTHON_S3TRANSFER_VERSION).tar.gz
PYTHON_S3TRANSFER_SITE = https://files.pythonhosted.org/packages/49/c5/0a5ce655109cb96b8dfad36908a4e108d15f5dc2eff8fbc3146c4312e704
PYTHON_S3TRANSFER_SETUP_TYPE = setuptools
PYTHON_S3TRANSFER_LICENSE = Apache-2.0
PYTHON_S3TRANSFER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
