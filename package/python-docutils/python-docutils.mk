################################################################################
#
# python-docutils
#
################################################################################

PYTHON_DOCUTILS_VERSION = 0.18.1
PYTHON_DOCUTILS_SOURCE = docutils-$(PYTHON_DOCUTILS_VERSION).tar.gz
PYTHON_DOCUTILS_SITE = https://files.pythonhosted.org/packages/57/b1/b880503681ea1b64df05106fc7e3c4e3801736cf63deffc6fa7fc5404cf5
PYTHON_DOCUTILS_LICENSE = Public Domain, BSD-2-Clause, BSD-3-Clause, Python-2.0, GPL-3.0+ (emacs mode)
PYTHON_DOCUTILS_LICENSE_FILES = COPYING.txt
PYTHON_DOCUTILS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
