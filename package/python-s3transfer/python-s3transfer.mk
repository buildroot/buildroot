################################################################################
#
# python-s3transfer
#
################################################################################

PYTHON_S3TRANSFER_VERSION = 0.16.0
PYTHON_S3TRANSFER_SOURCE = s3transfer-$(PYTHON_S3TRANSFER_VERSION).tar.gz
PYTHON_S3TRANSFER_SITE = https://files.pythonhosted.org/packages/05/04/74127fc843314818edfa81b5540e26dd537353b123a4edc563109d8f17dd
PYTHON_S3TRANSFER_SETUP_TYPE = setuptools
PYTHON_S3TRANSFER_LICENSE = Apache-2.0
PYTHON_S3TRANSFER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
