################################################################################
#
# python-urwid
#
################################################################################

PYTHON_URWID_VERSION = 3.0.4
PYTHON_URWID_SOURCE = urwid-$(PYTHON_URWID_VERSION).tar.gz
PYTHON_URWID_SITE = https://files.pythonhosted.org/packages/e0/4d/f0832a6bf0986bdd770d61f9cf9e9915741171502c0c399bf934c72a3e5e
PYTHON_URWID_LICENSE = LGPL-2.1+
PYTHON_URWID_LICENSE_FILES = COPYING
PYTHON_URWID_SETUP_TYPE = setuptools
PYTHON_URWID_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
