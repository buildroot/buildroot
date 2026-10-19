################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 4.2.4
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/d8/28/3893324bcadf8f89b1616637468d766af3f625008c0735bf704fdfa86617
PYTHON_FILELOCK_SETUP_TYPE = hatch
PYTHON_FILELOCK_LICENSE = MIT
PYTHON_FILELOCK_LICENSE_FILES = LICENSE
PYTHON_FILELOCK_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
