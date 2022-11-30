################################################################################
#
# python-typing-inspect
#
################################################################################

PYTHON_TYPING_INSPECT_VERSION = 0.8.0
PYTHON_TYPING_INSPECT_SOURCE = typing_inspect-$(PYTHON_TYPING_INSPECT_VERSION).tar.gz
PYTHON_TYPING_INSPECT_SITE = https://files.pythonhosted.org/packages/72/23/bed3ea644bcd77ffe9a7f591eb058c00739747e33ab94d80cc4319ddee8e
PYTHON_TYPING_INSPECT_SETUP_TYPE = setuptools
PYTHON_TYPING_INSPECT_LICENSE = MIT
PYTHON_TYPING_INSPECT_LICENSE_FILES = LICENSE

$(eval $(python-package))
