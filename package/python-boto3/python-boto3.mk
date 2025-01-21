################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.36.3
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/07/12/b9ad4c3dd6e6044243d08bae076795e41357651683f4fad99d5828c4291c
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
