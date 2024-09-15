################################################################################
#
# python-matplotlib-inline
#
################################################################################

PYTHON_MATPLOTLIB_INLINE_VERSION = 0.1.7
PYTHON_MATPLOTLIB_INLINE_SOURCE = matplotlib_inline-$(PYTHON_MATPLOTLIB_INLINE_VERSION).tar.gz
PYTHON_MATPLOTLIB_INLINE_SITE = https://files.pythonhosted.org/packages/99/5b/a36a337438a14116b16480db471ad061c36c3694df7c2084a0da7ba538b7
PYTHON_MATPLOTLIB_INLINE_SETUP_TYPE = setuptools
PYTHON_MATPLOTLIB_INLINE_LICENSE = BSD-3-Clause
PYTHON_MATPLOTLIB_INLINE_LICENSE_FILES = LICENSE

$(eval $(python-package))
