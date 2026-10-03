################################################################################
#
# python-docutils
#
################################################################################

PYTHON_DOCUTILS_VERSION = 0.23
PYTHON_DOCUTILS_SOURCE = docutils-$(PYTHON_DOCUTILS_VERSION).tar.gz
PYTHON_DOCUTILS_SITE = https://files.pythonhosted.org/packages/39/a4/5180d9afc57e8fca05601dd652bdff19604c218814037fe90ffc7625a50a
PYTHON_DOCUTILS_LICENSE = Public Domain, BSD-2-Clause, BSD-3-Clause, GPL-3.0+ (emacs mode)
PYTHON_DOCUTILS_LICENSE_FILES = COPYING.rst
PYTHON_DOCUTILS_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
