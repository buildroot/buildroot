################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.43.125
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/f2/c2/9285c749ca49c213ad90aa239884d0c5cbbdc58f02c4c44bcc4a3bf59023
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
