################################################################################
#
# python-argcomplete
#
################################################################################

PYTHON_ARGCOMPLETE_VERSION = 3.5.1
PYTHON_ARGCOMPLETE_SOURCE = argcomplete-$(PYTHON_ARGCOMPLETE_VERSION).tar.gz
PYTHON_ARGCOMPLETE_SITE = https://files.pythonhosted.org/packages/5f/39/27605e133e7f4bb0c8e48c9a6b87101515e3446003e0442761f6a02ac35e
PYTHON_ARGCOMPLETE_SETUP_TYPE = setuptools
PYTHON_ARGCOMPLETE_LICENSE = Apache-2.0
PYTHON_ARGCOMPLETE_LICENSE_FILES = LICENSE.rst
PYTHON_ARGCOMPLETE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
