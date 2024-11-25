################################################################################
#
# python-tinyrpc
#
################################################################################

PYTHON_TINYRPC_VERSION = 1.1.7
PYTHON_TINYRPC_SOURCE = tinyrpc-$(PYTHON_TINYRPC_VERSION).tar.gz
PYTHON_TINYRPC_SITE = https://files.pythonhosted.org/packages/6a/31/b0d0403cafda7965fab0741bcb7c63b26eab7fcfb605d4ece31a6f7b034d
PYTHON_TINYRPC_SETUP_TYPE = setuptools
PYTHON_TINYRPC_LICENSE = MIT
PYTHON_TINYRPC_LICENSE_FILES = LICENSE

$(eval $(python-package))
