################################################################################
#
# python-urwid-readline
#
################################################################################

PYTHON_URWID_READLINE_VERSION = 0.15.1
PYTHON_URWID_READLINE_SOURCE = urwid_readline-$(PYTHON_URWID_READLINE_VERSION).tar.gz
PYTHON_URWID_READLINE_SITE = https://files.pythonhosted.org/packages/ad/70/be318554495555eba7d8ff6e489f6f74ddb225b24086ba4af62a82e723fd
PYTHON_URWID_READLINE_SETUP_TYPE = setuptools
PYTHON_URWID_READLINE_LICENSE = MIT
PYTHON_URWID_READLINE_LICENSE_FILES = LICENSE.md LICENSE

$(eval $(python-package))
