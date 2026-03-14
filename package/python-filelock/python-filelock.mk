################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 3.25.2
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/94/b8/00651a0f559862f3bb7d6f7477b192afe3f583cc5e26403b44e59a55ab34
PYTHON_FILELOCK_SETUP_TYPE = hatch
PYTHON_FILELOCK_LICENSE = MIT
PYTHON_FILELOCK_LICENSE_FILES = LICENSE
PYTHON_FILELOCK_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
