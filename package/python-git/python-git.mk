################################################################################
#
# python-git
#
################################################################################

PYTHON_GIT_VERSION = 3.2.1
PYTHON_GIT_SOURCE = gitpython-$(PYTHON_GIT_VERSION).tar.gz
PYTHON_GIT_SITE = https://files.pythonhosted.org/packages/c0/ff/fee293f1ec3e1b64db6eb270e00964f29c086d769201474cedb8d1608930
PYTHON_GIT_LICENSE = BSD-3-Clause
PYTHON_GIT_LICENSE_FILES = LICENSE
PYTHON_GIT_SETUP_TYPE = setuptools

$(eval $(python-package))
