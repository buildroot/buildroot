################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.28.78
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/70/f7/da69e173dd5663775f114fad3827dcc49537e232e36266463ff70529f1a4
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
