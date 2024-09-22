################################################################################
#
# python-urwid-readline
#
################################################################################

PYTHON_URWID_READLINE_VERSION = 0.14
PYTHON_URWID_READLINE_SOURCE = urwid_readline-$(PYTHON_URWID_READLINE_VERSION).tar.gz
PYTHON_URWID_READLINE_SITE = https://files.pythonhosted.org/packages/2f/00/347dc37f9fb328a8386961157b6a31e71d603c17f2ed3098ca6bab513689
PYTHON_URWID_READLINE_SETUP_TYPE = setuptools
PYTHON_URWID_READLINE_LICENSE = MIT
PYTHON_URWID_READLINE_LICENSE_FILES = LICENSE.md LICENSE

$(eval $(python-package))
