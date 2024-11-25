################################################################################
#
# python-googleapis-common-protos
#
################################################################################

PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION = 1.65.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SOURCE = googleapis_common_protos-$(PYTHON_GOOGLEAPIS_COMMON_PROTOS_VERSION).tar.gz
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SITE = https://files.pythonhosted.org/packages/53/3b/1599ceafa875ffb951480c8c74f4b77646a6b80e80970698f2aa93c216ce
PYTHON_GOOGLEAPIS_COMMON_PROTOS_SETUP_TYPE = setuptools
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE = Apache-2.0
PYTHON_GOOGLEAPIS_COMMON_PROTOS_LICENSE_FILES = LICENSE

$(eval $(python-package))
