################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 3.20.2
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/c1/e0/a75dbe4bca1e7d41307323dad5ea2efdd95408f74ab2de8bd7dba9b51a1a
PYTHON_FILELOCK_SETUP_TYPE = hatch
PYTHON_FILELOCK_LICENSE = Public Domain
PYTHON_FILELOCK_LICENSE_FILES = LICENSE
PYTHON_FILELOCK_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
