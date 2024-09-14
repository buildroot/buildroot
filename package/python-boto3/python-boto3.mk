################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.35.19
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/80/85/d4119201c65b56a2bcc8dc328db98cd1c769a2376aea1613a6f5e8f2a88b
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
