################################################################################
#
# python-termcolor
#
################################################################################

PYTHON_TERMCOLOR_VERSION = 3.2.0
PYTHON_TERMCOLOR_SOURCE = termcolor-$(PYTHON_TERMCOLOR_VERSION).tar.gz
PYTHON_TERMCOLOR_SITE = https://files.pythonhosted.org/packages/87/56/ab275c2b56a5e2342568838f0d5e3e66a32354adcc159b495e374cda43f5
PYTHON_TERMCOLOR_SETUP_TYPE = hatch
PYTHON_TERMCOLOR_LICENSE = MIT
PYTHON_TERMCOLOR_LICENSE_FILES = COPYING.txt
PYTHON_TERMCOLOR_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
