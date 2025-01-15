################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.35.97
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/b0/0b/be51ba3bf22832bc918b4059ca182877681b02a45627c51d70efbbf1991d
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
