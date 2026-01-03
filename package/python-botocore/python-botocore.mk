################################################################################
#
# python-botocore
#
################################################################################

PYTHON_BOTOCORE_VERSION = 1.42.21
PYTHON_BOTOCORE_SOURCE = botocore-$(PYTHON_BOTOCORE_VERSION).tar.gz
PYTHON_BOTOCORE_SITE = https://files.pythonhosted.org/packages/4c/df/dfd07d75fda643ba07af75e33cfd72472a12bb13901812ca34e47f081507
PYTHON_BOTOCORE_SETUP_TYPE = setuptools
PYTHON_BOTOCORE_LICENSE = Apache-2.0
PYTHON_BOTOCORE_LICENSE_FILES = LICENSE.txt tests/unit/auth/aws4_testsuite/LICENSE

$(eval $(python-package))
