################################################################################
#
# python-git
#
################################################################################

PYTHON_GIT_VERSION = 3.1.44
PYTHON_GIT_SOURCE = gitpython-$(PYTHON_GIT_VERSION).tar.gz
PYTHON_GIT_SITE = https://files.pythonhosted.org/packages/c0/89/37df0b71473153574a5cdef8f242de422a0f5d26d7a9e231e6f169b4ad14
PYTHON_GIT_LICENSE = BSD-3-Clause
PYTHON_GIT_LICENSE_FILES = LICENSE
PYTHON_GIT_SETUP_TYPE = setuptools

$(eval $(python-package))
