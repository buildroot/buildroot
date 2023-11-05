################################################################################
#
# python-git
#
################################################################################

PYTHON_GIT_VERSION = 3.1.40
PYTHON_GIT_SOURCE = GitPython-$(PYTHON_GIT_VERSION).tar.gz
PYTHON_GIT_SITE = https://files.pythonhosted.org/packages/0d/b2/37265877ae607a2cbf9a471f4581dbf5ed13a501b90cb4c773f9ccfff3ea
PYTHON_GIT_LICENSE = BSD-3-Clause
PYTHON_GIT_LICENSE_FILES = LICENSE
PYTHON_GIT_SETUP_TYPE = setuptools

$(eval $(python-package))
