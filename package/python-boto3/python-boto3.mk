################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.42.68
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/06/ae/60c642aa5413e560b671da825329f510b29a77274ed0f580bde77562294d
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
