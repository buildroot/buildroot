################################################################################
#
# python-googleapis-common-protos
#
################################################################################

PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION = 1.66.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SOURCE = googleapis_common_protos-$(PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION).tar.gz
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SITE = https://files.pythonhosted.org/packages/ff/a7/8e9cccdb1c49870de6faea2a2764fa23f627dd290633103540209f03524c
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SETUP_TYPE = setuptools
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE = Apache-2.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE_FILES = LICENSE

$(eval $(python-package))
