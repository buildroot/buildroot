################################################################################
#
# python-boto3
#
################################################################################

PYTHON_BOTO3_VERSION = 1.35.86
PYTHON_BOTO3_SOURCE = boto3-$(PYTHON_BOTO3_VERSION).tar.gz
PYTHON_BOTO3_SITE = https://files.pythonhosted.org/packages/b7/23/0fe81184d4c3c4f640288dce790c705a76263c1aa688f684ef1dbe9d4f7d
PYTHON_BOTO3_SETUP_TYPE = setuptools
PYTHON_BOTO3_LICENSE = Apache-2.0
PYTHON_BOTO3_LICENSE_FILES = LICENSE

$(eval $(python-package))
