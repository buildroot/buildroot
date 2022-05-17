################################################################################
#
# python-typing-inspect
#
################################################################################

PYTHON_TYPING_INSPECT_VERSION = 0.7.1
PYTHON_TYPING_INSPECT_SOURCE = typing_inspect-$(PYTHON_TYPING_INSPECT_VERSION).tar.gz
PYTHON_TYPING_INSPECT_SITE = https://files.pythonhosted.org/packages/c3/da/864ce66818e308b38209d4b1ef0585921d28eb07621ba7d905a0e96bcc80
PYTHON_TYPING_INSPECT_SETUP_TYPE = setuptools
PYTHON_TYPING_INSPECT_LICENSE = MIT
PYTHON_TYPING_INSPECT_LICENSE_FILES = LICENSE

$(eval $(python-package))
