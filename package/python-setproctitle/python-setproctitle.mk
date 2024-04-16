################################################################################
#
# python-setproctitle
#
################################################################################

PYTHON_SETPROCTITLE_VERSION = 1.3.3
PYTHON_SETPROCTITLE_SOURCE = setproctitle-$(PYTHON_SETPROCTITLE_VERSION).tar.gz
PYTHON_SETPROCTITLE_SITE = https://files.pythonhosted.org/packages/ff/e1/b16b16a1aa12174349d15b73fd4b87e641a8ae3fb1163e80938dbbf6ae98
PYTHON_SETPROCTITLE_LICENSE = BSD-3-Clause
PYTHON_SETPROCTITLE_LICENSE_FILES = COPYRIGHT
PYTHON_SETPROCTITLE_SETUP_TYPE = setuptools

$(eval $(python-package))
