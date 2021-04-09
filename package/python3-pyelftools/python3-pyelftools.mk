################################################################################
#
# python3-pyelftools
#
################################################################################

# Please keep in sync with package/python-pyelftools/python-pyelftools.mk
PYTHON3_PYELFTOOLS_VERSION = 0.27
PYTHON3_PYELFTOOLS_SOURCE = pyelftools-$(PYTHON3_PYELFTOOLS_VERSION).tar.gz
PYTHON3_PYELFTOOLS_SITE = https://files.pythonhosted.org/packages/6b/b5/f7022f2d950327ba970ec85fb8f85c79244031092c129b6f34ab17514ae0
PYTHON3_PYELFTOOLS_LICENSE = Public domain
PYTHON3_PYELFTOOLS_LICENSE_FILES = LICENSE
PYTHON3_PYELFTOOLS_SETUP_TYPE = setuptools
HOST_PYTHON3_PYELFTOOLS_DL_SUBDIR = python-pyelftools
HOST_PYTHON3_PYELFTOOLS_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
