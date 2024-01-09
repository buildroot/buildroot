################################################################################
#
# python-matplotlib-inline
#
################################################################################

PYTHON_MATPLOTLIB_INLINE_VERSION = 0.1.6
PYTHON_MATPLOTLIB_INLINE_SOURCE = matplotlib-inline-$(PYTHON_MATPLOTLIB_INLINE_VERSION).tar.gz
PYTHON_MATPLOTLIB_INLINE_SITE = https://files.pythonhosted.org/packages/d9/50/3af8c0362f26108e54d58c7f38784a3bdae6b9a450bab48ee8482d737f44
PYTHON_MATPLOTLIB_INLINE_SETUP_TYPE = setuptools
PYTHON_MATPLOTLIB_INLINE_LICENSE = BSD-3-Clause
PYTHON_MATPLOTLIB_INLINE_LICENSE_FILES = LICENSE

$(eval $(python-package))
