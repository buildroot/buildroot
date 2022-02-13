################################################################################
#
# python-pyelftools
#
################################################################################

PYTHON_PYELFTOOLS_VERSION = 0.27
PYTHON_PYELFTOOLS_SOURCE = pyelftools-$(PYTHON_PYELFTOOLS_VERSION).tar.gz
PYTHON_PYELFTOOLS_SITE = https://files.pythonhosted.org/packages/6b/b5/f7022f2d950327ba970ec85fb8f85c79244031092c129b6f34ab17514ae0
PYTHON_PYELFTOOLS_LICENSE = Public domain
PYTHON_PYELFTOOLS_LICENSE_FILES = LICENSE
PYTHON_PYELFTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
