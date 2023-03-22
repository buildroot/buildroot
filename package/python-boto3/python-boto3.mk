################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.26.96
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/c2/9b/8e9124c3d0306ab2ee865e6adffcfcb0127bf0c327386d62d2c9db19b6ae
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
