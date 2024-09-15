################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 3.16.0
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/e6/76/3981447fd369539aba35797db99a8e2ff7ed01d9aa63e9344a31658b8d81
PYTHON_FILELOCK_SETUP_TYPE = pep517
PYTHON_FILELOCK_LICENSE = Public Domain
PYTHON_FILELOCK_LICENSE_FILES = LICENSE
PYTHON_FILELOCK_DEPENDENCIES = host-python-hatchling host-python-hatch-vcs

$(eval $(python-package))
