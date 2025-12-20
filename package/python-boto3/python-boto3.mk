################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.42.14
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/09/72/e236ca627bc0461710685f5b7438f759ef3b4106e0e08dda08513a6539ab
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
