################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.43.103
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/46/59/012898d78087105e9c20fe31605d3f1999921745e1890ee0f0d993846e2e
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
