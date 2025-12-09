################################################################################
#
# python-argcomplete
#
################################################################################

PYTHON_ARGCOMPLETE_VERSION = 3.6.3
PYTHON_ARGCOMPLETE_SOURCE = argcomplete-$(PYTHON_ARGCOMPLETE_VERSION).tar.gz
PYTHON_ARGCOMPLETE_SITE = https://files.pythonhosted.org/packages/38/61/0b9ae6399dd4a58d8c1b1dc5a27d6f2808023d0b5dd3104bb99f45a33ff6
PYTHON_ARGCOMPLETE_SETUP_TYPE = hatch
PYTHON_ARGCOMPLETE_LICENSE = Apache-2.0
PYTHON_ARGCOMPLETE_LICENSE_FILES = LICENSE.rst
PYTHON_ARGCOMPLETE_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
