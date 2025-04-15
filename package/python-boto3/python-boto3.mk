################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.37.34
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/39/5d/6b1ca20ba4da350799509a69f2d295ae11d5ec08a98e82f74b5708a8180c
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
