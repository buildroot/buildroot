################################################################################
#
# python-posix-ipc
#
################################################################################

PYTHON_POSIX_IPC_VERSION = 1.3.0
PYTHON_POSIX_IPC_SOURCE = posix_ipc-$(PYTHON_POSIX_IPC_VERSION).tar.gz
PYTHON_POSIX_IPC_SITE = https://files.pythonhosted.org/packages/2b/a1/16d4b5a7dfc3dbb5965debe0415b6dc4866d4c94a1229f5b12cde7b78de8
PYTHON_POSIX_IPC_LICENSE = BSD-3-Clause
PYTHON_POSIX_IPC_LICENSE_FILES = LICENSE
PYTHON_POSIX_IPC_SETUP_TYPE = setuptools

$(eval $(python-package))
