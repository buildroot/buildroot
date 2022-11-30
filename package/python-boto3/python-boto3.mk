################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.24.8
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/60/3b/6fed306341003fd059f402d22747ba33d07b8ac8bfe53dbedb2c6e42ee3b
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
