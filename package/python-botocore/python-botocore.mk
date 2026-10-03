################################################################################
#
# python-botocore
#
################################################################################

PYTHON_BOTOCORE_VERSION = 1.43.103
PYTHON_BOTOCORE_SOURCE = botocore-$(PYTHON_BOTOCORE_VERSION).tar.gz
PYTHON_BOTOCORE_SITE = https://files.pythonhosted.org/packages/3c/83/acbee6f2e3b1f02de935fef0c48a387511bf979149dc6b44466aaafba6a5
PYTHON_BOTOCORE_SETUP_TYPE = setuptools
PYTHON_BOTOCORE_LICENSE = Apache-2.0
PYTHON_BOTOCORE_LICENSE_FILES = LICENSE.txt tests/unit/auth/aws4_testsuite/LICENSE

$(eval $(python-package))
