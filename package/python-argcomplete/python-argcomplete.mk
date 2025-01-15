################################################################################
#
# python-argcomplete
#
################################################################################

PYTHON_ARGCOMPLETE_VERSION = 3.5.3
PYTHON_ARGCOMPLETE_SOURCE = argcomplete-$(PYTHON_ARGCOMPLETE_VERSION).tar.gz
PYTHON_ARGCOMPLETE_SITE = https://files.pythonhosted.org/packages/0c/be/6c23d80cb966fb8f83fb1ebfb988351ae6b0554d0c3a613ee4531c026597
PYTHON_ARGCOMPLETE_SETUP_TYPE = hatch
PYTHON_ARGCOMPLETE_LICENSE = Apache-2.0
PYTHON_ARGCOMPLETE_LICENSE_FILES = LICENSE.rst
PYTHON_ARGCOMPLETE_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
