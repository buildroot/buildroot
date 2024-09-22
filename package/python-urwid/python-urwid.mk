################################################################################
#
# python-urwid
#
################################################################################

PYTHON_URWID_VERSION = 2.6.15
PYTHON_URWID_SOURCE = urwid-$(PYTHON_URWID_VERSION).tar.gz
PYTHON_URWID_SITE = https://files.pythonhosted.org/packages/85/b7/516b0bbb7dd9fc313c6443b35d86b6f91b3baa83d2c4016e4d8e0df5a5e3
PYTHON_URWID_LICENSE = LGPL-2.1+
PYTHON_URWID_LICENSE_FILES = COPYING
PYTHON_URWID_SETUP_TYPE = setuptools
PYTHON_URWID_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
