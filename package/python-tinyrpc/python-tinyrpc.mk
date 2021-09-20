################################################################################
#
# python-tinyrpc
#
################################################################################

PYTHON_TINYRPC_VERSION = 1.1.1
PYTHON_TINYRPC_SOURCE = tinyrpc-$(PYTHON_TINYRPC_VERSION).tar.gz
PYTHON_TINYRPC_SITE = https://files.pythonhosted.org/packages/6a/63/0851365686da1ca9ab03d63b035eccf87a1d85b743ce07d079462350da33
PYTHON_TINYRPC_SETUP_TYPE = setuptools
PYTHON_TINYRPC_LICENSE = MIT
PYTHON_TINYRPC_LICENSE_FILES = LICENSE

$(eval $(python-package))
