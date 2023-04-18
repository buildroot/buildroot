################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.26.115
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/78/a8/b07686bd9a56e2556708d562c6b8ade423f3cf4cb1b7c3cbc9ed6c24d022
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
