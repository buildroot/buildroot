################################################################################
#
# python-lark
#
################################################################################

PYTHON_LARK_VERSION = 1.3.1
PYTHON_LARK_SOURCE = lark-$(PYTHON_LARK_VERSION).tar.gz
PYTHON_LARK_SITE = https://files.pythonhosted.org/packages/da/34/28fff3ab31ccff1fd4f6c7c7b0ceb2b6968d8ea4950663eadcb5720591a0
PYTHON_LARK_SETUP_TYPE = setuptools
PYTHON_LARK_LICENSE = MIT
PYTHON_LARK_LICENSE_FILES = LICENSE
PYTHON_LARK_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
