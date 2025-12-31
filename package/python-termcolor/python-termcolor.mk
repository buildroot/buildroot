################################################################################
#
# python-termcolor
#
################################################################################

PYTHON_TERMCOLOR_VERSION = 3.3.0
PYTHON_TERMCOLOR_SOURCE = termcolor-$(PYTHON_TERMCOLOR_VERSION).tar.gz
PYTHON_TERMCOLOR_SITE = https://files.pythonhosted.org/packages/46/79/cf31d7a93a8fdc6aa0fbb665be84426a8c5a557d9240b6239e9e11e35fc5
PYTHON_TERMCOLOR_SETUP_TYPE = hatch
PYTHON_TERMCOLOR_LICENSE = MIT
PYTHON_TERMCOLOR_LICENSE_FILES = COPYING.txt
PYTHON_TERMCOLOR_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
