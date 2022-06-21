################################################################################
#
# python-lark
#
################################################################################

PYTHON_LARK_VERSION = 1.1.2
PYTHON_LARK_SOURCE = lark-$(PYTHON_LARK_VERSION).tar.gz
PYTHON_LARK_SITE = https://files.pythonhosted.org/packages/a3/c5/11d0a086590b207ad1b6c9ba6e019f8290652f3d703cdb002d72e220dd99
PYTHON_LARK_SETUP_TYPE = setuptools
PYTHON_LARK_LICENSE = MIT
PYTHON_LARK_LICENSE_FILES = LICENSE

$(eval $(python-package))
