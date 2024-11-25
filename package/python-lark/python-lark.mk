################################################################################
#
# python-lark
#
################################################################################

PYTHON_LARK_VERSION = 1.2.2
PYTHON_LARK_SOURCE = lark-$(PYTHON_LARK_VERSION).tar.gz
PYTHON_LARK_SITE = https://files.pythonhosted.org/packages/af/60/bc7622aefb2aee1c0b4ba23c1446d3e30225c8770b38d7aedbfb65ca9d5a
PYTHON_LARK_SETUP_TYPE = setuptools
PYTHON_LARK_LICENSE = MIT
PYTHON_LARK_LICENSE_FILES = LICENSE

$(eval $(python-package))
