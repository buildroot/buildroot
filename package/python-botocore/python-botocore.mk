################################################################################
#
# python-botocore
#
################################################################################

PYTHON_BOTOCORE_VERSION = 1.35.57
PYTHON_BOTOCORE_SOURCE = botocore-$(PYTHON_BOTOCORE_VERSION).tar.gz
PYTHON_BOTOCORE_SITE = https://files.pythonhosted.org/packages/61/17/65b0a3bb507b19a7a1c6cc7c63e374906891798986f0ba2b6ad174ece86a
PYTHON_BOTOCORE_SETUP_TYPE = setuptools
PYTHON_BOTOCORE_LICENSE = Apache-2.0
PYTHON_BOTOCORE_LICENSE_FILES = LICENSE.txt tests/unit/auth/aws4_testsuite/LICENSE

$(eval $(python-package))
