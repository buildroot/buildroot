################################################################################
#
# python-googleapis-common-protos
#
################################################################################

PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION = 1.76.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SOURCE = googleapis_common_protos-$(PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION).tar.gz
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SITE = https://files.pythonhosted.org/packages/62/b6/bc095b23a3e0d978e75c8c18cabe4c11f791837410670e4486f0d539bfba
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SETUP_TYPE = setuptools
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE = Apache-2.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE_FILES = LICENSE

$(eval $(python-package))
