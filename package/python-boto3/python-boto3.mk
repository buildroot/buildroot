################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.18.48
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/d4/1e/7d6bf1b92199121ec5c020868402b90ba1a4fef6941aafaff970a664d83a
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
