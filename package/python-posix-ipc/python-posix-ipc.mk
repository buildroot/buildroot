################################################################################
#
# python-posix-ipc
#
################################################################################

PYTHON_POSIX_IPC_VERSION = 1.1.0
PYTHON_POSIX_IPC_SOURCE = posix_ipc-$(PYTHON_POSIX_IPC_VERSION).tar.gz
PYTHON_POSIX_IPC_SITE = https://files.pythonhosted.org/packages/41/72/90b6702782921c0e3e0b10a66f2a47d8cfaf9c2255d763ab45cc8cea25eb
PYTHON_POSIX_IPC_LICENSE = BSD-3-Clause
PYTHON_POSIX_IPC_LICENSE_FILES = LICENSE
PYTHON_POSIX_IPC_SETUP_TYPE = setuptools

$(eval $(python-package))
