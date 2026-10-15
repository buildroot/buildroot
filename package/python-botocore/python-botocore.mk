################################################################################
#
# python-botocore
#
################################################################################

PYTHON_BOTOCORE_VERSION = 1.43.114
PYTHON_BOTOCORE_SOURCE = botocore-$(PYTHON_BOTOCORE_VERSION).tar.gz
PYTHON_BOTOCORE_SITE = https://files.pythonhosted.org/packages/ce/c8/b508359d1f3846a918c06807a9ae27eee063f904559269e42ccde9de09ea
PYTHON_BOTOCORE_SETUP_TYPE = setuptools
PYTHON_BOTOCORE_LICENSE = Apache-2.0
PYTHON_BOTOCORE_LICENSE_FILES = LICENSE.txt tests/unit/auth/aws4_testsuite/LICENSE

$(eval $(python-package))
