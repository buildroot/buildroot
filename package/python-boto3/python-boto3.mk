################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.26.27
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/62/7b/7cdcb980d9d90c910a6abec2cdee0ff6aa7a3d8afea4044ffd968d5c107c
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
