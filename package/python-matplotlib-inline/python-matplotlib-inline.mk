################################################################################
#
# python-matplotlib-inline
#
################################################################################

PYTHON_MATPLOTLIB_INLINE_VERSION = 0.2.2
PYTHON_MATPLOTLIB_INLINE_SOURCE = matplotlib_inline-$(PYTHON_MATPLOTLIB_INLINE_VERSION).tar.gz
PYTHON_MATPLOTLIB_INLINE_SITE = https://files.pythonhosted.org/packages/bd/c0/9f7c9a46090390368a4d7bcb76bb87a4a36c421e4c0792cdb53486ffac7a
PYTHON_MATPLOTLIB_INLINE_SETUP_TYPE = flit
PYTHON_MATPLOTLIB_INLINE_LICENSE = BSD-3-Clause
PYTHON_MATPLOTLIB_INLINE_LICENSE_FILES = LICENSE

$(eval $(python-package))
