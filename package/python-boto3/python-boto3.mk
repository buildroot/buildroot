################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.35.53
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/12/c1/1dc34b322d2f022d190c34dd4aa7f1a242d73633c25061bf56bd1319fe05
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
