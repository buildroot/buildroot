################################################################################
#
# python-lark
#
################################################################################

PYTHON_LARK_VERSION = 1.1.8
PYTHON_LARK_SOURCE = lark-$(PYTHON_LARK_VERSION).tar.gz
PYTHON_LARK_SITE = https://files.pythonhosted.org/packages/12/1c/b466b58dacac15ffefce9bcb5128e18948a143849610a7d5300f31920be0
PYTHON_LARK_SETUP_TYPE = setuptools
PYTHON_LARK_LICENSE = MIT
PYTHON_LARK_LICENSE_FILES = LICENSE

$(eval $(python-package))
