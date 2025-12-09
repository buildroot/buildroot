################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.42.5
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/8b/91/c00b45b5ca95184f7ab6140f586ba7d23074168ee3feae3eaf6954cc11c3
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
