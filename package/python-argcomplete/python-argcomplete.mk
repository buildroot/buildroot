################################################################################
#
# python-argcomplete
#
################################################################################

PYTHON_ARGCOMPLETE_VERSION = 3.5.2
PYTHON_ARGCOMPLETE_SOURCE = argcomplete-$(PYTHON_ARGCOMPLETE_VERSION).tar.gz
PYTHON_ARGCOMPLETE_SITE = https://files.pythonhosted.org/packages/7f/03/581b1c29d88fffaa08abbced2e628c34dd92d32f1adaed7e42fc416938b0
PYTHON_ARGCOMPLETE_SETUP_TYPE = setuptools
PYTHON_ARGCOMPLETE_LICENSE = Apache-2.0
PYTHON_ARGCOMPLETE_LICENSE_FILES = LICENSE.rst
PYTHON_ARGCOMPLETE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
