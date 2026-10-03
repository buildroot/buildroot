################################################################################
#
# python-setproctitle
#
################################################################################

PYTHON_SETPROCTITLE_VERSION = 1.3.8
PYTHON_SETPROCTITLE_SOURCE = setproctitle-$(PYTHON_SETPROCTITLE_VERSION).tar.gz
PYTHON_SETPROCTITLE_SITE = https://files.pythonhosted.org/packages/49/b0/6b8a516c5a9e9630bd5293db78314ac012f690305fe93beadea388626efb
PYTHON_SETPROCTITLE_LICENSE = BSD-3-Clause
PYTHON_SETPROCTITLE_LICENSE_FILES = LICENSE
PYTHON_SETPROCTITLE_SETUP_TYPE = setuptools

$(eval $(python-package))
