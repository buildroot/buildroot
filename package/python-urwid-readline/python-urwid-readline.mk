################################################################################
#
# python-urwid-readline
#
################################################################################

PYTHON_URWID_READLINE_VERSION = 0.13
PYTHON_URWID_READLINE_SOURCE = urwid_readline-$(PYTHON_URWID_READLINE_VERSION).tar.gz
PYTHON_URWID_READLINE_SITE = https://files.pythonhosted.org/packages/ab/bb/c5b3fec22268d97ad30232f5533d4a5939d4df7ed3917a8d20d447f1d0a7
PYTHON_URWID_READLINE_LICENSE = MIT
PYTHON_URWID_READLINE_SETUP_TYPE = setuptools

$(eval $(python-package))
