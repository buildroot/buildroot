################################################################################
#
# python-git
#
################################################################################

PYTHON_GIT_VERSION = 3.1.43
PYTHON_GIT_SOURCE = GitPython-$(PYTHON_GIT_VERSION).tar.gz
PYTHON_GIT_SITE = https://files.pythonhosted.org/packages/b6/a1/106fd9fa2dd989b6fb36e5893961f82992cf676381707253e0bf93eb1662
PYTHON_GIT_LICENSE = BSD-3-Clause
PYTHON_GIT_LICENSE_FILES = LICENSE
PYTHON_GIT_SETUP_TYPE = setuptools

$(eval $(python-package))
