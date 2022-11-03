################################################################################
#
# python-setproctitle
#
################################################################################

PYTHON_SETPROCTITLE_VERSION = 1.3.2
PYTHON_SETPROCTITLE_SOURCE = setproctitle-$(PYTHON_SETPROCTITLE_VERSION).tar.gz
PYTHON_SETPROCTITLE_SITE = https://files.pythonhosted.org/packages/b5/47/ac709629ddb9779fee29b7d10ae9580f60a4b37e49bce72360ddf9a79cdc
PYTHON_SETPROCTITLE_LICENSE = BSD-3-Clause
PYTHON_SETPROCTITLE_LICENSE_FILES = COPYRIGHT
PYTHON_SETPROCTITLE_SETUP_TYPE = setuptools

$(eval $(python-package))
