################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.26.0
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/77/18/91af4ff58b26d03af8bf8e0759c4087b77032bdc54199d750905080c669a
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
