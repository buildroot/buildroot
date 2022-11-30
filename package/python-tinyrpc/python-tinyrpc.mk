################################################################################
#
# python-tinyrpc
#
################################################################################

PYTHON_TINYRPC_VERSION = 1.1.4
PYTHON_TINYRPC_SOURCE = tinyrpc-$(PYTHON_TINYRPC_VERSION).tar.gz
PYTHON_TINYRPC_SITE = https://files.pythonhosted.org/packages/d2/86/2741f0c74cc339416c9803b6393eaf230254ecf36ffd839614799e15a202
PYTHON_TINYRPC_SETUP_TYPE = setuptools
PYTHON_TINYRPC_LICENSE = MIT
PYTHON_TINYRPC_LICENSE_FILES = LICENSE

$(eval $(python-package))
