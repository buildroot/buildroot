################################################################################
#
# python-pyelftools
#
################################################################################

PYTHON_PYELFTOOLS_VERSION = 0.33
PYTHON_PYELFTOOLS_SOURCE = pyelftools-$(PYTHON_PYELFTOOLS_VERSION).tar.gz
PYTHON_PYELFTOOLS_SITE = https://files.pythonhosted.org/packages/a3/11/767522582afab1b884d277de0e6e011640cb9d7292a38694b4b1a1df1ae8
PYTHON_PYELFTOOLS_LICENSE = Public domain
PYTHON_PYELFTOOLS_LICENSE_FILES = LICENSE
PYTHON_PYELFTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
