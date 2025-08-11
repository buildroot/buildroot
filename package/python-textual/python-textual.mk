################################################################################
#
# python-textual
#
################################################################################

PYTHON_TEXTUAL_VERSION = 5.3.0
PYTHON_TEXTUAL_SOURCE = textual-$(PYTHON_TEXTUAL_VERSION).tar.gz
PYTHON_TEXTUAL_SITE = https://files.pythonhosted.org/packages/ba/ce/f0f938d33d9bebbf8629e0020be00c560ddfa90a23ebe727c2e5aa3f30cf
PYTHON_TEXTUAL_SETUP_TYPE = poetry
PYTHON_TEXTUAL_LICENSE = MIT
PYTHON_TEXTUAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
