################################################################################
#
# python-matplotlib-inline
#
################################################################################

PYTHON_MATPLOTLIB_INLINE_VERSION = 0.2.1
PYTHON_MATPLOTLIB_INLINE_SOURCE = matplotlib_inline-$(PYTHON_MATPLOTLIB_INLINE_VERSION).tar.gz
PYTHON_MATPLOTLIB_INLINE_SITE = https://files.pythonhosted.org/packages/c7/74/97e72a36efd4ae2bccb3463284300f8953f199b5ffbc04cbbb0ec78f74b1
PYTHON_MATPLOTLIB_INLINE_SETUP_TYPE = flit
PYTHON_MATPLOTLIB_INLINE_LICENSE = BSD-3-Clause
PYTHON_MATPLOTLIB_INLINE_LICENSE_FILES = LICENSE

$(eval $(python-package))
