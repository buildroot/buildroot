################################################################################
#
# python-lark
#
################################################################################

PYTHON_LARK_VERSION = 1.1.4
PYTHON_LARK_SOURCE = lark-$(PYTHON_LARK_VERSION).tar.gz
PYTHON_LARK_SITE = https://files.pythonhosted.org/packages/1d/08/eb2590d4f824b5a947d866c603799fa70278f1372cbf8d15b7b4823dfb2b
PYTHON_LARK_SETUP_TYPE = setuptools
PYTHON_LARK_LICENSE = MIT
PYTHON_LARK_LICENSE_FILES = LICENSE

$(eval $(python-package))
