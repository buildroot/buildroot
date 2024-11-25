################################################################################
#
# python-typing-inspect
#
################################################################################

PYTHON_TYPING_INSPECT_VERSION = 0.9.0
PYTHON_TYPING_INSPECT_SOURCE = typing_inspect-$(PYTHON_TYPING_INSPECT_VERSION).tar.gz
PYTHON_TYPING_INSPECT_SITE = https://files.pythonhosted.org/packages/dc/74/1789779d91f1961fa9438e9a8710cdae6bd138c80d7303996933d117264a
PYTHON_TYPING_INSPECT_SETUP_TYPE = setuptools
PYTHON_TYPING_INSPECT_LICENSE = MIT
PYTHON_TYPING_INSPECT_LICENSE_FILES = LICENSE

$(eval $(python-package))
