################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.42.21
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/27/36/999f23a821567334ecdfaec31fad556f5569383006543be63fdd1e17193f
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
