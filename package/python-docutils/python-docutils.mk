################################################################################
#
# python-docutils
#
################################################################################

PYTHON_DOCUTILS_VERSION = 0.22.4
PYTHON_DOCUTILS_SOURCE = docutils-$(PYTHON_DOCUTILS_VERSION).tar.gz
PYTHON_DOCUTILS_SITE = https://files.pythonhosted.org/packages/ae/b6/03bb70946330e88ffec97aefd3ea75ba575cb2e762061e0e62a213befee8
PYTHON_DOCUTILS_LICENSE = Public Domain, BSD-2-Clause, BSD-3-Clause, GPL-3.0+ (emacs mode)
PYTHON_DOCUTILS_LICENSE_FILES = COPYING.rst
PYTHON_DOCUTILS_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
