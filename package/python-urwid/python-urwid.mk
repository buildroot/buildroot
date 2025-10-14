################################################################################
#
# python-urwid
#
################################################################################

PYTHON_URWID_VERSION = 3.0.3
PYTHON_URWID_SOURCE = urwid-$(PYTHON_URWID_VERSION).tar.gz
PYTHON_URWID_SITE = https://files.pythonhosted.org/packages/bb/d3/09683323e2290732a39dc92ca5031d5e5ddda56f8d236f885a400535b29a
PYTHON_URWID_LICENSE = LGPL-2.1+
PYTHON_URWID_LICENSE_FILES = COPYING
PYTHON_URWID_SETUP_TYPE = setuptools
PYTHON_URWID_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
