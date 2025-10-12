################################################################################
#
# python-googleapis-common-protos
#
################################################################################

PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION = 1.70.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SOURCE = googleapis_common_protos-$(PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION).tar.gz
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SITE = https://files.pythonhosted.org/packages/39/24/33db22342cf4a2ea27c9955e6713140fedd51e8b141b5ce5260897020f1a
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SETUP_TYPE = setuptools
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE = Apache-2.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE_FILES = LICENSE

$(eval $(python-package))
