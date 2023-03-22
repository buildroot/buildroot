################################################################################
#
# python-botocore
#
################################################################################

PYTHON_BOTOCORE_VERSION = 1.29.96
PYTHON_BOTOCORE_SOURCE = botocore-$(PYTHON_BOTOCORE_VERSION).tar.gz
PYTHON_BOTOCORE_SITE = https://files.pythonhosted.org/packages/2d/b5/4a986aeb4e3d182f7ef116705962d3c98c0263beaf87c49836b7dfb91837
PYTHON_BOTOCORE_SETUP_TYPE = setuptools
PYTHON_BOTOCORE_LICENSE = Apache-2.0
PYTHON_BOTOCORE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
