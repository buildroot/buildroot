################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.35.27
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/01/0b/068d62d2ace3f34a5771c37817c55de2ee74f73c696d4c815b271b66cf12
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
