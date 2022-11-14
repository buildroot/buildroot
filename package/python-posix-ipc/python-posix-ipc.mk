################################################################################
#
# python-posix-ipc
#
################################################################################

PYTHON_POSIX_IPC_VERSION = 1.0.5
PYTHON_POSIX_IPC_SOURCE = posix_ipc-$(PYTHON_POSIX_IPC_VERSION).tar.gz
PYTHON_POSIX_IPC_SITE = https://files.pythonhosted.org/packages/bc/2f/9a7901aa26fb0e02a671b989ba814d059a0f45af85cea31b9c9eef7e2dda
PYTHON_POSIX_IPC_LICENSE = BSD-3-Clause
PYTHON_POSIX_IPC_LICENSE_FILES = LICENSE
PYTHON_POSIX_IPC_SETUP_TYPE = setuptools

$(eval $(python-package))
