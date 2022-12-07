################################################################################
#
# python-termcolor
#
################################################################################

PYTHON_TERMCOLOR_VERSION = 2.1.0
PYTHON_TERMCOLOR_SOURCE = termcolor-$(PYTHON_TERMCOLOR_VERSION).tar.gz
PYTHON_TERMCOLOR_SITE = https://files.pythonhosted.org/packages/62/1a/e78a930f70dd576f2a7250a98263ac973a80d6f1a395d89328844881a0c0
PYTHON_TERMCOLOR_SETUP_TYPE = pep517
PYTHON_TERMCOLOR_LICENSE = MIT
PYTHON_TERMCOLOR_LICENSE_FILES = COPYING.txt
PYTHON_TERMCOLOR_DEPENDENCIES = host-python-hatchling host-python-hatch-vcs

$(eval $(python-package))
