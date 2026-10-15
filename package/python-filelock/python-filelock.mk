################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 4.2.0
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/f4/a9/1af41b37c3279712b22cdc63aac78a52432202b6fe1f9666a2a3d2831fb4
PYTHON_FILELOCK_SETUP_TYPE = hatch
PYTHON_FILELOCK_LICENSE = MIT
PYTHON_FILELOCK_LICENSE_FILES = LICENSE
PYTHON_FILELOCK_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
