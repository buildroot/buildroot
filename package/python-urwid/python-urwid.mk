################################################################################
#
# python-urwid
#
################################################################################

PYTHON_URWID_VERSION = 4.1.7
PYTHON_URWID_SOURCE = urwid-$(PYTHON_URWID_VERSION).tar.gz
PYTHON_URWID_SITE = https://files.pythonhosted.org/packages/6f/55/ae4b607277b6c6a7d02e145e9a24c777e5bd2b9189d7145f0afc731bf639
PYTHON_URWID_LICENSE = LGPL-2.1+
PYTHON_URWID_LICENSE_FILES = COPYING
PYTHON_URWID_SETUP_TYPE = setuptools
PYTHON_URWID_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
