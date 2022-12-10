################################################################################
#
# python-termcolor
#
################################################################################

PYTHON_TERMCOLOR_VERSION = 2.1.1
PYTHON_TERMCOLOR_SOURCE = termcolor-$(PYTHON_TERMCOLOR_VERSION).tar.gz
PYTHON_TERMCOLOR_SITE = https://files.pythonhosted.org/packages/19/da/ff1f0906818a5bd2e69e773d88801ca3c9e92d0d7caa99db1665658819ea
PYTHON_TERMCOLOR_SETUP_TYPE = pep517
PYTHON_TERMCOLOR_LICENSE = MIT
PYTHON_TERMCOLOR_LICENSE_FILES = COPYING.txt
PYTHON_TERMCOLOR_DEPENDENCIES = host-python-hatchling host-python-hatch-vcs

$(eval $(python-package))
