################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 3.8.0
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/95/55/b897882bffb8213456363e646bf9e9fa704ffda5a7d140edf935a9e02c7b
PYTHON_FILELOCK_SETUP_TYPE = setuptools
PYTHON_FILELOCK_LICENSE = Public Domain
PYTHON_FILELOCK_LICENSE_FILES = LICENSE

$(eval $(python-package))
